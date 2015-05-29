%Wrapper function to send command and wait for response from arm controller
function sendCommand(t,command)

    %Send command to TCPIP port
    fprintf(t,command)

    %Pause until a message is received
    while(~t.BytesAvailable)
    end
    %Then flush the input buffer
    flushinput(t)
end