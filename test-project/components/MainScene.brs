sub init()
    TRY
        explodingMethod()
    CATCH error
        dataDogConfigurationObject = {applicationID: "[application_id]", clientToken: "[application_token]"}
        dataDogTrackerConfiguration = DataDogConfiguration(dataDogConfigurationObject)
        dataDogTracker = DataDogTracker(dataDogTrackerConfiguration)
        dataDogTracker.sendError(error)

        ' Catch errors in a SceneGraph Project ->
        ' dataDogTracker = CreateObject("roSGNode", "dataDogTrackerComponent")
        ' dataDogConfigurationObject = {applicationID: "[application_id]", clientToken: "[application_token]"}
        ' dataDogTrackerConfig = dataDogTracker.callFunc("createDataDogConfiguration", dataDogConfigurationObject)
        ' dataDogTracker.callFunc("setConfiguration", dataDogTrackerConfig)
        ' dataDogTracker.callFunc("sendError", error)
    end TRY
end sub

sub explodingMethod()
    x = 1
    ? x.foo
end sub
