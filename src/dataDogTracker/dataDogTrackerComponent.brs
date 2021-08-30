sub init()
end sub

function createDataDogConfiguration(applicationId = "" as String, clientToken = "" as String, site = "" as String, service = "" as String, sampleRate = 100 as Integer, trackInteractions = true as Boolean) as Object
    return DataDogConfiguration(applicationId, clientToken, site, service, sampleRate, trackInteractions)
end function

sub setConfiguration(configuration as Object)
    m.dataDogTracker = DataDogTracker(configuration)
end sub

sub sendError(errorDetails as Object)
    m.dataDogTracker.sendError(errorDetails)
end sub
