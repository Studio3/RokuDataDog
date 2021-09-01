# Roku DataDog error tracker
- - -
A tool to track your ROKU application errors.

## Requirements
- [NODE.js](https://nodejs.org/en/download/)
- [ROPM](https://github.com/rokucommunity/ropm)

## Installation
Use following command to get the package to your application
```
ropm install roku-data-dog
```
The package should be stored in `/components` directory

### How to use DataDogTracker:
- Create your RUM application in DataDog
- Create a `try-catch` block where you expect any error to occure

#### Used with a sceneGraph project:
- Inside the `CATCH`:
 - Create dataDogTracker component
 - Create and set the dataDog configuration
 - Send the error to dataDog
 - In the following example you can observe how to set up what was explained above:
```
dataDogTracker = CreateObject("roSGNode", "dataDogTrackerComponent")
dataDogConfigurationObject = {applicationID: "[application_id]", clientToken: "[application_token]"}
dataDogTrackerConfig = dataDogTracker.callFunc("createDataDogConfiguration", dataDogConfigurationObject)
dataDogTracker.callFunc("setConfiguration", dataDogTrackerConfig)
dataDogTracker.callFunc("sendError", error)
```

#### Used with brightscript project:

- Inside the xml file of your component you have to include the scripts for the following components:
```
viewSample.brs
errorSample.brs
dataDogConfig.brs
dataDogTracker.brs
dataDogConfiguration.brs
```
- Inside the `CATCH`:
 - Set the dataDog configuration
 - Send the error to dataDog
 - In the following example you can observe how to set up what was explained above:
```
dataDogConfigurationObject = {applicationID: "[application_id]", clientToken: "[application_token]"}
dataDogTrackerConfiguration = DataDogConfiguration(dataDogConfigurationObject)
dataDogTracker = DataDogTracker(dataDogTrackerConfiguration)
dataDogTracker.sendError(error)
```

##### The following fields can be set inside the DataDog configuration:
- applicationID - type: STRING - default: ""
- clientToken - type: STRING - default: ""
- site - type: STRING - default: ""
- service - type: STRING - default: ""
- sampleRate - type: INTEGER - default: 100
- trackInteractions - type: BOOLEAN - default: true

## How to use the Test Project
- Download `test-project` file to your machine
- Note that in the scene component there are 2 ways of the DataDog tracker implementation:
 - BrightScript implementation (currently used)
 - SceneGraph implementation (commented inside the code)
- Replace `[application_id]` with your application id
- Replace `[application_token]` with your application token
- Archive the project and run it on your device
- Look in DataDog RUM application to see the view with one error in it

## Data recieved by DataDog RUM application
Currently the application is sending a view event and one error event, both sharing same ids.
#### What you can see inside the error

- date
- country
- application ID
- application version
- device model
- device OS version
- message
- backtrace

## License
This library is licensed under the Apache 2.0 License. See the [LICENSE](https://github.com/Studio3/RokuDataDog/blob/main/LICENSE) for details.
