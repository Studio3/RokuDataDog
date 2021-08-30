function DataDogConfiguration(applicationId = "" as String, clientToken = "" as String, site = "" as String, service = "" as String, sampleRate = 100 as Integer, trackInteractions = true as Boolean) as Object
    return {
        APPLICATION_ID: applicationId
        CLIENT_TOKEN: clientToken
        SITE: site
        SERVICE: service
        SAMPLE_RATE: sampleRate
        TRACK_INTERACTIONS: trackInteractions
    }
end function
