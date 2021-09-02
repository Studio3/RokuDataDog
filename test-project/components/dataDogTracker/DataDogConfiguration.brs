function DataDogConfiguration(clientConfiguration) as Object
    configuration = {
        applicationId: ""
        clientToken: ""
        site: ""
        service: ""
        sampleRate: 100
        trackInteractions: true
    }
    configuration.append(clientConfiguration)

    return configuration
end function
