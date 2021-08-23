sub init()
    m.appInfo = CreateObject("roAppInfo")
    m.requestService = requestService()

    m.top.functionName = "execute"
end sub

sub execute()
    roUrlTransfer = getRoUrlTransfer()
    m.requestService.send(roUrlTransfer)
end sub

function getRoUrlTransfer() as Object
    builder = requestBuilder()
    builder.setUrl(m.top.url)
    builder.setMethod("POST")
    builder.setBody(m.top.body)

    return builder.build()
end function
