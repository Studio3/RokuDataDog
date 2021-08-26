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

sub init()
    m.deviceInfo = CreateObject("roDeviceInfo")
    m.appInfo = CreateObject("roAppInfo")
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

sub registerError(errorDetails as Object)
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
    setDefaultRequestData(view)

    return view
end function

function getErrorData(errorDetails as Object) as Object
    errorData = getErrorSample()
    setDefaultRequestData(errorData)
    errorData.error.message = errorDetails.message
    errorData.error.backtrace = errorDetails.backtrace

    return errorData
end function

sub setDefaultRequestData(requestBody as Object)
    requestBody.date = m.date
    requestBody.view.id = m.viewID
    requestBody.session.id = m.sessionID
    requestBody.application.id = m.applicationID
end sub

function getRUMApplicationURL(applicationToken as String) as String
    config = getDataDogConfig()
    applicationDetails = substitute("variant:{0},version:{1},env:{2}",m.deviceInfo.GetModelDetails().modelNumber, m.appInfo.getVersion(), m.appInfo.getID())
    return substitute("{0}{1}{2},{3}",config.url, applicationToken, config.query, applicationDetails)
end function

sub sendEvent(body as Object)
    task = CreateObject("roSgNode", "dataDogTransferTask")
    task.url = m.url
    task.body = body
    task.control = "RUN"
end sub
