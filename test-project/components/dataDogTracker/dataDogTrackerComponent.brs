sub init()
end sub

function createDataDogConfiguration(configuration as Object) as Object
    return DataDogConfiguration(configuration)
end function

sub setConfiguration(configuration as Object)
    m.dataDogTracker = DataDogTracker(configuration)
end sub

sub sendError(errorDetails as Object)
    m.dataDogTracker.sendError(errorDetails)
end sub
