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

function ApiResponse(roUrlEvent as Dynamic) as Object
    if roUrlEvent = invalid then roUrlEvent = CreateObject("roUrlEvent")

    this = {
        _roUrlEvent: roUrlEvent

        asJson: ApiResponse_asJson
        getStatusCode: ApiResponse_getStatusCode
        getFailureReason: ApiResponse_getFailureReason
        isSuccessStatusCode: ApiResponse_isSuccessStatusCode
    }

    return this
end function

function ApiResponse_isSuccessStatusCode() as Boolean
    return m.getStatusCode() > 199 and m.getStatusCode() < 300
end function

function ApiResponse_getStatusCode() as Integer
    return m._roUrlEvent.getResponseCode()
end function

function ApiResponse_getFailureReason() as String
    return m._roUrlEvent.getFailureReason()
end function

function ApiResponse_asJson() as Dynamic
    return ParseJson(m._roUrlEvent.getString())
end function
