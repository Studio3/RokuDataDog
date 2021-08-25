sub main(args as Object)
    m.port = CreateObject("roMessagePort")
    screen = CreateObject("roSGScreen")
    screen.setMessagePort(m.port)

    m.scene = screen.CreateScene("MainScene")
    screen.show()

    runMainLoop()
end sub

function runMainLoop() as Void
    while true
        msg = wait(0, m.port)
        msgType = type(msg)

        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end function
