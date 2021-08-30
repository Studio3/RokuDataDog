sub init()
    TRY
        explodingMethod()
    CATCH error
        dataDogTrackerConfiguration = DataDogConfiguration("[application_id]", "[application_token]")
        dataDogTracker = DataDogTracker(dataDogTrackerConfiguration)
        dataDogTracker.sendError(error)

        ' Catch errors in a SceneGraph Project ->
        ' dataDogTracker = CreateObject("roSGNode", "dataDogTrackerComponent")
        ' dataDogTrackerConfig = dataDogTracker.callFunc("createDataDogConfiguration", "[application_id]", "[application_token]")
        ' dataDogTracker.callFunc("setConfiguration", dataDogTrackerConfig)
        ' dataDogTracker.callFunc("sendError", error)
    end TRY
end sub

sub explodingMethod()
    x = 1
    ? x.foo
end sub
