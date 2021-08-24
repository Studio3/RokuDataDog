function HttpMethods() as Object
    if m._HttpMethod = invalid then m._HttpMethod = {
        GET: "GET"
        POST: "POST"
        HEAD: "HEAD"
        DELETE: "DELETE"
        PATCH: "PATCH"
    }

    return m._HttpMethod
end function
