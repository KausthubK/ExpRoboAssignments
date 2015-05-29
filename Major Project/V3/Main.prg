''''''''''''''''''''''''''''''''''''''''''''
' Wrapper Functions...                     '
' Don 't change anything in this section...'
''''''''''''''''''''''''''''''''''''''''''''	
Boolean isConnected
#define MoveBlockHeight (30) '110
#define BlockWidth (80)
Function SetupArm()
	Motor On
	If (1) Then
	    Power High
		SpeedS 2000 ' 80
		AccelS 500 ' 50
		Accel 50, 50 ' 15, 15
		Speed 15
		SpeedR 75
		AccelR 200
	Else
	    Power Low
		SpeedS 80
		AccelS 50
		Accel 15, 15
		Speed 3
	EndIf
	TLSet 1, XY(0, 0, 180, 0, 0, 0) '75
	Tool 1
Fend

Function GoHome()
	Move LJM(Here :Z(MoveBlockHeight + BlockWidth))
	Move LJM(Here :U(90) :V(0) :W(180)) ROT
	Move LJM(XY(0, 360, MoveBlockHeight + BlockWidth, 90, 0, 180))
Fend
Function CloseGripper
	On 10 ' toggle bit on controller
	Wait 0.2
Fend
Function OpenGripper
	Off 10 ' toggle bit on controller
	Wait 0.2
Fend
Function SetToolHeight(Height As Real)
	If (Height < 0) Then
		Height = 0
	EndIf
	'Go Here :Z(MoveBlockHeight + Height * BlockWidth) LJM
	Move LJM(Here :Z(MoveBlockHeight + Height * BlockWidth))
Fend
Function PositionTool(XPos As Real, YPos As Real)
	P1 = Here
	Real z
	z = CZ(P1)
    'Go LJM(Here :X(XPos) :Y(YPos))
	Move LJM(Here :X(XPos) :Y(YPos))
Fend
Function PositionToolFast(XPos As Real, YPos As Real)
	P1 = Here
	Real z
	z = CZ(P1)
    Go LJM(Here :X(XPos) :Y(YPos))
	'Move LJM(Here :X(XPos) :Y(YPos))
Fend
Function SetToolAngle(Angle As Real)
	If (Angle < 0) Then
		Angle = 0
	EndIf
	If (Angle > 180) Then
		Angle = 180
	EndIf
	Move LJM(Here :U(90 + Angle) :V(0) :W(180)) ROT
Fend


'          My Wrapper Functions            '
''''''''''''''''''''''''''''''''''''''''''''

Function peekCard	'keep pick up/move/grab seperate?'

      GoHome

      JTran 5, (90 - (-41.672))	'+90'
      JTran 3, (90 - (-26.295))	'+90'
      JTran 2, (-90 - (-22.033))	'-90'
      
Fend


Function unpeekCard

      JTran 2, -(-90 - (-22.033))	'double check'
      JTran 3, -(90 - (-26.295))
      JTran 5, -(90 - (-41.672))

Fend

Function displayCard

    JTran 5, 90
    
Fend

Function back

    JTran 5, -(90)
  
Fend

' ... end wrapper functions                '
''''''''''''''''''''''''''''''''''''''''''''


' ... end wrapper functions                '
''''''''''''''''''''''''''''''''''''''''''''


Function RemoveBlock(BlockNum As Real)
'    Go above current block height
    SetToolHeight(BlockNum + 1)
'    Go to tower
    PositionTool(0, 490)
    SetToolHeight(BlockNum)
'    Get block
    CloseGripper
'    Go above current block height
    SetToolHeight(BlockNum + 1)
'    Go home
    PositionTool(0, 290)
    SetToolHeight(1)
Fend

Function PositionArmHide
	'Move arm out of the way
	SetupArm
	OpenGripper
	GoHome
	PositionTool(300, 300)
	PositionTool(300, 60)
		
Fend

Function PositionArmUnhide
	'Move arm back to home after moving out of the way
	SetupArm
	PositionTool(300, 300)
	GoHome
		
Fend



Function openTCPIP
	Print "Opening TCP/IP connection"
	OpenNet #202 As Server
	Print "Waiting for connection..."
	WaitNet #202
	Print "Connected."
	isConnected = True
Fend


Function parseCommands(commandString$ As String)
	String cmds$(0)
	Integer i
	Integer check
	
	'Print commandString$
	
	ParseStr commandString$, cmds$(), Chr$(13)	'Extract cmds (separated by line break)'
	For i = 0 To UBound(cmds$)
		check = InStr(cmds$(i), ">")
		If (InStr(cmds$(i), "<") = 1 And check > 0) Then	'Ensure command is inside <>'
			executeCommand(Mid$(cmds$(i), 2, check - 2))	'Execute command (minus <>)'
		Else
			Print "Erroneous command '", cmds$(i), "'"
		EndIf
	Next i
Fend

Function executeCommand(command$ As String)
	Integer numArgs
	String cmds$(0)
	'Print command$
		
	ParseStr command$, cmds$(), Chr$(44)	'See if there's a comma, and split command'
	numArgs = UBound(cmds$) + 1
	
	
	'If two params, then it's x,y position'
	If (numArgs = 2) Then
		String cmd1$, cmd2$		
		Real param1, param2
		
		cmd1$ = Left$(cmds$(0), 1)
		param1 = Val(Right$(cmds$(0), Len(cmds$(0)) - 1))
		cmd2$ = Left$(cmds$(1), 1)
		param2 = Val(Right$(cmds$(1), Len(cmds$(1)) - 1))
		
	
		If InStr(cmd1$, "x") = 1 And InStr(cmd2$, "y") = 1 Then
			Print "Positioning Tool at (", param1, ",", param2, ")"
			PositionTool(param1, param2)
		ElseIf InStr(cmd1$, "y") = 1 And InStr(cmd2$, "x") = 1 Then
			Print "Positioning Tool at (", param2, ",", param1, ")"
			PositionTool(param2, param1)
		Else
			Print ("Error, check position command format")
		EndIf
		
	'Otherwise, it could be tool height, tool angle, open/close'
	ElseIf (numArgs = 1) Then
		String cmd$
		Real param
		cmd$ = Left$(command$, 1)
		
		If InStr(cmd$, "h") = 1 Then ' h corresponds to tool height h for height'
			param = Val(Right$(command$, Len(command$) - 1))
			Print "Setting Tool Height at ", param
			SetToolHeight(param)
		ElseIf InStr(cmd$, "a") = 1 Then ' a corresponds to tool angle a for angle'
			param = Val(Right$(command$, Len(command$) - 1))
			Print "Setting Tool Angle at ", param
			SetToolAngle(param)
		ElseIf InStr(cmd$, "c") = 1 Then ' c corresponds to close gripper c for close'
			Print "Closing Gripper"
			CloseGripper
		ElseIf InStr(cmd$, "o") = 1 Then ' o corresponds to open gripper o for open'
			Print "Opening Gripper"
			OpenGripper
		ElseIf InStr(cmd$, "s") = 1 Then 's corresponds to hide arm command s for stash'
			Print "Hiding Arm"
			PositionArmHide
		ElseIf InStr(cmd$, "r") = 1 Then 'r corresponds to unhide arm command r for reveal'
			Print "UnHiding Arm"
			PositionArmUnhide
			
		ElseIf InStr(cmd$, "d") = 1 Then 'd corresponds to display card command'
			Print "Displaying Card"
			displayCard
		ElseIf InStr(cmd$, "b") = 1 Then 'B corresponds to back card command'
			Print "J5 back down"
			back
			
		ElseIf InStr(cmd$, "p") = 1 Then
			'Print "Positioning Tool at (", param2, ",", param3, ")"'
			Print "Peeking"
			'PositionTool(param2, param3)'
			'SetToolHeight(0)''
			'CloseGripper'
			'SetToolHeight(2)'
			
			GoHome
			
			peekCard
						
			
		ElseIf InStr(cmd$, "u") = 1 Then
		
			Print "UnPeeking"
			unpeekCard
		
			'Print "Positioning Tool at (",' param2, ",", param1, ")"'
			'PositionTool(param2, param1)
			
			'SetToolHeight(0)'
			'OpenGripper'
			'SetToolHeight(2)'
			'SetToolAngle(0)'
					
		Else
		Else
			Print ("Error, make sure first letter matches a command")
		EndIf
	Else
		Print ("Error, too many args")
	EndIf
		
		
Fend

Function main
	isConnected = False
	SetupArm
	GoHome
	
	Xqt tcpServ
	
	Do '' Keep Alive
	Loop
	
Fend


Function tcpServ
	String strIn$
	Integer inCount
	
	PositionArmHide	'Move arm out of the way (out of the image)
	
	openTCPIP	'Open comms'
	
	Boolean first_command
	first_command = True	'Currently waiting for first command
	
	Do While (1)
		inCount = ChkNet(202)
		If (inCount > 255) Then
			inCount = 255
		EndIf
		
		If (inCount < 0) Then
			' Error
			Print "Network Read Error = ", inCount
			CloseNet #202
			openTCPIP	'Reconnect'
		ElseIf (inCount = 0) Then
			'No bytes recieved
			'Print "."
		Else
			If (first_command) Then
				PositionArmUnhide	'Go back home from the hidden position'
				first_command = False
			EndIf
			' Some bytes ready to be read	
			Read #202, strIn$, inCount
			Print "Read ", strIn$
			parseCommands(strIn$)
			Write #202, ("Complete.\n")	'Send a string to inform client the command is complete'
		EndIf
	Loop
Fend

