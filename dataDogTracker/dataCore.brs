sub init()
    m.deviceInfo = CreateObject("roDeviceInfo")
    m.viewID = getUUID()
    m.sessionID = getUUID()
    m.date = getDateInMillis()
    setApplicationInfo()
end sub

sub setApplicationInfo()
    clientConfiguration = getClientConfiguration()
    m.applicationID = clientConfiguration.applicationID
    m.url = getRUMApplicationURL(clientConfiguration.clientToken)
end sub

sub registerError(errorDetails as Object, applicationID as String, applicationToken as String)
    view = getViewData()

    if view <> invalid
        sendEvent(view)
        errorData = getErrorData(errorDetails)
        sendEvent(errorData)
    end if
end sub

function getUUID() as String
    return m.deviceInfo.getRandomUUID()
end function

function getDateInMillis()
    dateInMillis = CreateObject("roLongInteger")
    time = CreateObject("roDateTime")
    ts = time.AsSeconds()
    tms = time.GetMilliseconds()
    dateInMillis.SetLongInt( ts )
    dateInMillis.SetLongInt( dateInMillis.GetLongInt() * 1000 )
    dateInMillis.SetLongInt( dateInMillis.GetLongInt() + tms )

    return dateInMillis
end function

function getViewData() as Object
    view = getViewSample()
    view.view.id = m.viewID
    view.date = m.date
    view.session.id = m.sessionID
    view.application.id = m.applicationID

    return view
end function

function getErrorData(errorDetails as Object) as Object
    errorData = getErrorSample()
    errorData.date = m.date
    errorData.view.id = m.viewID
    errorData.session.id = m.sessionID
    errorData.application.id = m.applicationID
    errorData.error.message = errorDetails.message
    errorData.error.backtrace = errorDetails.backtrace

    return errorData
end function

function getRUMApplicationURL(applicationToken as String) as String
    config = getDataDogConfig()
    return substitute("{0}{1}{2},version:{3}",config.url, applicationToken, config.query, m.deviceInfo.GetModelDetails().modelNumber)
end function

sub sendEvent(body as Object)
    task = CreateObject("roSgNode", "dataDogTransferTask")
    task.url = m.url
    task.body = body
    task.control = "RUN"
end sub
