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
The package should be stored in `/components` file

### How to use it:
- Create your RUM application in DataDog
- Define your application ID and your client token(got from DataDog RUM app) inside a file called `clientConfiguration.brs`. You have the file `clientConfiguration.brs.example` as model.
- Create a `try-catch` block where you expect any error to occure
- Inside the `catch`, send your error to the DataDog RUM application. To do that you'll have to create dataCore component and call `registerError` function; like in the following example:
```
dataDogTracker = CreateObject("roSgNode", "dataCore")
dataDogTracker.callFunc("registerError", e)
```
Where `e` - the error got on `CATCH`

## How to use the Test Project
- Download `test-project` file to your machine
- Update `clientConfiguration.brs` file with your ID and token
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
