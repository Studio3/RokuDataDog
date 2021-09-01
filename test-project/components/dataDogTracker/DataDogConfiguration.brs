function DataDogConfiguration(clientConfiguration) as Object
    defaultConfiguration = getDefaultDataDogConfiguration()

    for each configField in defaultConfiguration
        if clientConfiguration[configField] = invalid then clientConfiguration[configField] = defaultConfiguration[configField]
    end for

    return {
        APPLICATION_ID: clientConfiguration.applicationId
        CLIENT_TOKEN: clientConfiguration.clientToken
        SITE: clientConfiguration.site
        SERVICE: clientConfiguration.service
        SAMPLE_RATE: clientConfiguration.sampleRate
        TRACK_INTERACTIONS: clientConfiguration.trackInteractions
    }
end function

function getDefaultDataDogConfiguration() as Object
    return {
        applicationId: ""
        clientToken: ""
        site: ""
        service: ""
        sampleRate: 100
        trackInteractions: true
    }
end function
