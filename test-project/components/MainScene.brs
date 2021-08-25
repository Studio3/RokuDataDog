sub init()
    TRY
        explodingMethod()
    CATCH e
        dataDogTracker = CreateObject("roSgNode", "dataCore")
        dataDogTracker.callFunc("registerError", e)
    end TRY
end sub

sub explodingMethod()
    x = 1
    ? x.foo
end sub
