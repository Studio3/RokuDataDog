function ApiRequest(url as String, method as String, body={} as Object, headers={} as Object) as Object
    this = {
        url: url
        method: method
        body: body
        headers: headers
    }

    return this
end function
