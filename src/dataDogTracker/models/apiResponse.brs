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
