' Copyright 2021 EPIX Entertainment LLC
'
' Licensed under the Apache License, Version 2.0 (the "License");
' you may not use this file except in compliance with the License.
' You may obtain a copy of the License at
'
'     http://www.apache.org/licenses/LICENSE-2.0
'
' Unless required by applicable law or agreed to in writing, software
' distributed under the License is distributed on an "AS IS" BASIS,
' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
' See the License for the specific language governing permissions and
' limitations under the License.

function Tracker(configuration as Object) as Object
    return {
        CONFIGURATION: configuration

        sendError: Tracker__sendError

        _setDefaultValues: Tracker___setDefaultValues
        _getUUID: Tracker___getUUID
        _getDateInMillis: Tracker___getDateInMillis
        _getViewData: Tracker___getViewData
        _getErrorData: Tracker___getErrorData
        _setDefaultRequestData: Tracker___setDefaultRequestData
        _getRUMApplicationURL: Tracker___getRUMApplicationURL
        _sendEvent: Tracker___sendEvent
    }
end function

sub Tracker___setDefaultValues()
    m.deviceInfo = CreateObject("roDeviceInfo")
    m.appInfo = CreateObject("roAppInfo")
    m.viewID = m._getUUID()
    m.sessionID = m._getUUID()
    m.date = m._getDateInMillis()
    m.applicationID = m.CONFIGURATION.applicationid
    m.url = m._getRUMApplicationURL(m.CONFIGURATION.clienttoken)
end sub

sub Tracker__sendError(errorDetails as Object)
    m._setDefaultValues()
    view = m._getViewData()

    if view <> invalid
        m._sendEvent(view)
        errorData = m._getErrorData(errorDetails)
        m._sendEvent(errorData)
    end if
end sub

function Tracker___getUUID() as String
    return m.deviceInfo.getRandomUUID()
end function

function Tracker___getDateInMillis()
    dateInMillis = CreateObject("roLongInteger")
    time = CreateObject("roDateTime")
    ts = time.AsSeconds()
    tms = time.GetMilliseconds()
    dateInMillis.SetLongInt( ts )
    dateInMillis.SetLongInt( dateInMillis.GetLongInt() * 1000 )
    dateInMillis.SetLongInt( dateInMillis.GetLongInt() + tms )

    return dateInMillis
end function

function Tracker___getViewData() as Object
    view = getViewSample()
    m._setDefaultRequestData(view)

    return view
end function

function Tracker___getErrorData(errorDetails as Object) as Object
    errorData = getErrorSample()
    m._setDefaultRequestData(errorData)
    errorData.error.message = errorDetails.message
    errorData.error.backtrace = errorDetails.backtrace

    return errorData
end function

sub Tracker___setDefaultRequestData(requestBody as Object)
    requestBody.date = m.date
    requestBody.session.id = m.sessionID
    requestBody.view.name = m.appInfo.getTitle()
    requestBody.session.id = m.sessionID
    requestBody.application.id = m.applicationID
end sub

function Tracker___getRUMApplicationURL(applicationToken as String) as String
    config = getConfig()
    applicationDetails = substitute("variant:{0},version:{1},env:{2}",m.deviceInfo.GetModelDetails().modelNumber, m.appInfo.getVersion(), m.appInfo.getID())
    return substitute("{0}{1}{2},{3}",config.url, applicationToken, config.query, applicationDetails)
end function

sub Tracker___sendEvent(body as Object)
    task = CreateObject("roSgNode", "TransferTask")
    task.url = m.url
    task.body = body
    task.control = "RUN"
end sub
