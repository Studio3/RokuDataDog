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

function RequestService() as Object
    return {
        TIMEOUT: 60000

        httpMethod: HttpMethods()

        send: RequestService__send

        _getMessage: RequestService___getMessage
        _sendRequest: RequestService___sendRequest
        _printResponse: RequestService___printResponse
        _createResponse: RequestService___createResponse
        _createRoUrlTransfer: RequestService___createRoUrlTransfer
    }
end function

function RequestService__send(requestObject as Object) as Object
    roUrlTransfer = m._sendRequest(requestObject)
    apiResponse = m._createResponse(roUrlTransfer)

    m._printResponse(apiResponse, requestObject)
    return apiResponse
end function

function RequestService___createResponse(roUrlTransfer as Object) as Object
    roUrlEvent = m._getMessage(roUrlTransfer.getPort())

    return ApiResponse(roUrlEvent)
end function

function RequestService___sendRequest(requestObject as Object) as Object
    roUrlTransfer = m._createRoUrlTransfer(requestObject)

    if requestObject.method = m.httpMethod.GET
        roUrlTransfer.asyncGetToString()
    else if requestObject.method = m.httpMethod.HEAD
        roUrlTransfer.asyncHead()
    else
        roUrlTransfer.asyncPostFromString(requestObject.body)
    end if

    return roUrlTransfer
end function

function RequestService___getMessage(port as Object) as Object
    roUrlEvent = invalid
    msg = wait(m.TIMEOUT, port)

    if type(msg) = "roUrlEvent"
        roUrlEvent = msg
    end if

    return roUrlEvent
end function

sub RequestService___printResponse(apiResponse as Object, requestObject as Object)
    ? substitute("debug: {0}: {1} <- [{2}] {3}", apiResponse.getFailureReason(), apiResponse.getStatusCode().toStr(), requestObject.method, requestObject.url)
end sub

function RequestService___createRoUrlTransfer(requestObject as Object) as Object
    roUrlTransfer = CreateObject("roUrlTransfer")

    roUrlTransfer.setUrl(requestObject.url)
    roUrlTransfer.setRequest(requestObject.method)

    roUrlTransfer.setPort(CreateObject("roMessagePort"))
    roUrlTransfer.setHeaders(requestObject.headers)

    roUrlTransfer.addHeader("Content-Type", "application/json")
    roUrlTransfer.addHeader("X-Roku-Reserved-Dev-Id", "")

    roUrlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    roUrlTransfer.InitClientCertificates()
    roUrlTransfer.retainBodyOnError(true)

    return roUrlTransfer
end function
