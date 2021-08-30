# Roku DataDog error tracker
- - -
A tool to track your ROKU application errors.

## Requirements
- [NODE.js](https://nodejs.org/en/download/)
- [ROPM](https://github.com/rokucommunity/ropm)

## Installation
Use following command to get the package to your application
```
ropm install rokudatadog
```
The package should be stored in `/components` directory

### How to use it:
- Create your RUM application in DataDog
- Create a `try-catch` block where you expect any error to occure
- Inside the `catch`:
 - Create dataDogTracker component
 - Create and set the dataDog configuration
 - Send the error to dataDog
 - In the following example you can observe how to set up what was explained above:
```
 dataDogTracker = CreateObject("roSGNode", "dataDogTracker")
 dataDogTrackerConfig = dataDogTracker.callFunc("createDataDogConfiguration", "[application_id]", "[application_token]")
 dataDogTracker.callFunc("setConfiguration", dataDogTrackerConfig)
 dataDogTracker.callFunc("sendError", error)
```

## How to use the Test Project
- Download `test-project` file to your machine
- Note that in the scene component there are 2 ways of the DataDog tracher implementation:
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
