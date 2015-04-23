%Send instructions to the Robotic Arm
%%Code as presented as part of the assignment specification

function sendCommand(t,command)

    %Send command to TCPIP port
    fprintf(t,command)

%     %Pause until a message is received
    while(~t.BytesAvailable)
    end
%     %Then flush the input buffer
    flushinput(t)
end