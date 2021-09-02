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
