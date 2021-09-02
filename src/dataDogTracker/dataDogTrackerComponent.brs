sub init()
end sub

sub setConfiguration(clientConfiguration as Object)
    configuration = DataDogConfiguration(clientConfiguration)
    m.dataDogTracker = DataDogTracker(configuration)
end sub

sub sendError(errorDetails as Object)
    m.dataDogTracker.sendError(errorDetails)
end sub
