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
        ' dataDogTracker.callFunc("setConfiguration", dataDogConfigurationObject)
        ' dataDogTracker.callFunc("sendError", error)
    end TRY
end sub

sub explodingMethod()
    x = 1
    ? x.foo
end sub
