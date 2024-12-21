URL = 'ws://127.0.0.1:7567'
CLUSTER = 'testing'
KEY = '$f$cbfe$$afa$ef$'
nodeID = nil

while true do
    local ws, err = http.websocket(URL)
    if not ws then
        sleep(5)
        goto continue
    end

    while true do
        local msg = ws.receive()
        if not msg then
            break
        end
        if msg == '0' then
            print("recieved handshake, sending cluster")
            ws.send(CLUSTER)
            if ws.recieve == '2' then
                if nodeID then
                    print("Node ID is configured, authing.")
                    ws.send(nodeID)
                else
                    print("No node ID provided. Initiating registry.")
                    ws.send('8')
                    if ws.receive() == '9' then
                        ws.send(KEY)
                        nodeID = ws.receive()
                    end
                end
                if ws.recieve() == "3" then
                            
                end
            end
        end

    end
    ::continue::
end