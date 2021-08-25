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
