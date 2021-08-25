function getDataDogConfig() as Object
    return {
        url:  "https://rum-http-intake.logs.datadoghq.com/v1/input/"
        query:  "?ddsource=react-native&ddtags=service%3Aroku"
    }
end function
