sub init()
    m.url = m.top.findNode("url")
    m.TIMEOUT = 60000
    m.appInfo = CreateObject("roAppInfo")

    m.top.functionName = "execute"
end sub

sub execute()
    roUrlTransfer = getRoUrlTransfer()
    data = FormatJson(m.top.body)
    roUrlTransfer.asyncPostFromString(data)
    transferApi = getUrlTransferAPI(roUrlTransfer.getPort())
    m.top.data = transferApi.getResponseCode()
end sub

function getUrlTransferAPI(port) as Object
    roUrlEvent = invalid
    msg = wait(m.TIMEOUT, port)

    if type(msg) = "roUrlEvent"
        roUrlEvent = msg
    end if

    return roUrlEvent
end function

function getRoUrlTransfer() as Object
    roUrlTransfer = CreateObject("roUrlTransfer")
    roUrlTransfer.setPort(CreateObject("roMessagePort"))
    roUrlTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
    roUrlTransfer.setUrl(m.top.url)
    roUrlTransfer.addHeader("Content-Type", "application/json")
    roUrlTransfer.addHeader("X-Roku-Reserved-Dev-Id", "")
    roUrlTransfer.setRequest("POST")
    roUrlTransfer.InitClientCertificates()
    roUrlTransfer.retainBodyOnError(true)

    return roUrlTransfer
end function
