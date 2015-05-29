%Connect
function t = epsonConnect()

    t=tcpip('192.168.0.1', 2020, 'NetworkRole', 'client');
    fopen(t);

end