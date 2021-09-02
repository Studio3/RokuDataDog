function DataDogTracker(configuration as Object) as Object
    return {
        CONFIGURATION: configuration

        sendError: DataDogTracker__sendError

        _setDefaultValues: DataDogTracker___setDefaultValues
        _getUUID: DataDogTracker___getUUID
        _getDateInMillis: DataDogTracker___getDateInMillis
        _getViewData: DataDogTracker___getViewData
        _getErrorData: DataDogTracker___getErrorData
        _setDefaultRequestData: DataDogTracker___setDefaultRequestData
        _getRUMApplicationURL: DataDogTracker___getRUMApplicationURL
        _sendEvent: DataDogTracker___sendEvent
    }
end function

sub DataDogTracker___setDefaultValues()
    m.deviceInfo = CreateObject("roDeviceInfo")
    m.appInfo = CreateObject("roAppInfo")
    m.viewID = m._getUUID()
    m.sessionID = m._getUUID()
    m.date = m._getDateInMillis()
    m.applicationID = m.CONFIGURATION.applicationid
    m.url = m._getRUMApplicationURL(m.CONFIGURATION.clienttoken)
end sub

sub DataDogTracker__sendError(errorDetails as Object)
    m._setDefaultValues()
    view = m._getViewData()

    if view <> invalid
        m._sendEvent(view)
        errorData = m._getErrorData(errorDetails)
        m._sendEvent(errorData)
    end if
end sub

function DataDogTracker___getUUID() as String
    return m.deviceInfo.getRandomUUID()
end function

function DataDogTracker___getDateInMillis()
    dateInMillis = CreateObject("roLongInteger")
    time = CreateObject("roDateTime")
    ts = time.AsSeconds()
    tms = time.GetMilliseconds()
    dateInMillis.SetLongInt( ts )
    dateInMillis.SetLongInt( dateInMillis.GetLongInt() * 1000 )
    dateInMillis.SetLongInt( dateInMillis.GetLongInt() + tms )

    return dateInMillis
end function

function DataDogTracker___getViewData() as Object
    view = getViewSample()
    m._setDefaultRequestData(view)

    return view
end function

function DataDogTracker___getErrorData(errorDetails as Object) as Object
    errorData = getErrorSample()
    m._setDefaultRequestData(errorData)
    errorData.error.message = errorDetails.message
    errorData.error.backtrace = errorDetails.backtrace

    return errorData
end function

sub DataDogTracker___setDefaultRequestData(requestBody as Object)
    requestBody.date = m.date
    requestBody.view.id = m.viewID
    requestBody.session.id = m.sessionID
    requestBody.application.id = m.applicationID
end sub

function DataDogTracker___getRUMApplicationURL(applicationToken as String) as String
    config = getDataDogConfig()
    applicationDetails = substitute("variant:{0},version:{1},env:{2}",m.deviceInfo.GetModelDetails().modelNumber, m.appInfo.getVersion(), m.appInfo.getID())
    return substitute("{0}{1}{2},{3}",config.url, applicationToken, config.query, applicationDetails)
end function

sub DataDogTracker___sendEvent(body as Object)
    task = CreateObject("roSgNode", "dataDogTransferTask")
    task.url = m.url
    task.body = body
    task.control = "RUN"
end sub
