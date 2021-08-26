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

function RequestBuilder() as Object
    this = {
        _baseUrl: invalid
        _method: invalid
        _body: {}
        _headers: {}
    }

    this.setUrl = function(url as String)
        m._baseUrl = url
    end function

    this.setMethod = function(method as String)
        m._method = method
    end function

    this.setBody = function(body as Object)
        m._body = body
    end function

    this.setHeader = function(key as String, value as Object)
        m._headers.addReplace(key, value)
    end function

    this.setHeaders = function(headers as Object)
        for each header in headers.items()
            m.setHeader(header.key, header.value)
        end for
    end function

    this.getUrl = function() as String
        return m._baseUrl
    end function

    this.getMethod = function() as String
        return m._method
    end function

    this.getBody = function() as Object
        return FormatJson(m._body)
    end function

    this.getHeaders = function() as Object
        return m._headers
    end function

    this.build = function()
        url = m.getUrl()
        method = m.getMethod()
        body = m.getBody()
        headers = m.getHeaders()

        return ApiRequest(url, method, body, headers)
    end function

    return this
end function
