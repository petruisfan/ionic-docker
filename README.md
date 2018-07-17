# ionic-docker
Ionic build tool based on docker

## Background

Ionic projects have always been hard to build after a period of time. The main componets for building an Android project with ionic are:
- ionic version
- cordova version
- android sdk version

Only certain combinations of the 3 can build a specific Ionic project. If working on multiple ionic projects in the same time and one of them requires a cordova update there is the risk that all other projects will not build anymore

## Purpose

This project was built to ease ionic development and build by providing an portable integrated environment using docker to handle all ops related tasks.
It is dedicated to building Android projects with Ionic.

The docker image provided can be used to:
- build apks
- develop the app

It is a combination of docker file configurations and shell script for automation.

The docker image contains:
- Java 8
- Node 8
- Ionic
- Cordova
- TypeScript
- Android SDK
- Gradle

## Usage

### Developing

Just run:

```
$> docker-compose up
```

There is a default configuratio file called docker-compose.yml which will automatically download the docker image from docker hub and run the `ionic serve` command in the current directory.
It also exports the `8100` port, so just open up the browser and load:

```
http://localhost:8100
```

And you ionic app can be viewed there directly :)

Other debug ports can be exposed if needed.

### Building the image yourself

There is a central docker image configuration file called `build/Dockerfile`.
This configuration can be updated to suit more specific needs and add more build tools. Just update this file and run:

```
$> cd build
$> ./docker-build.sh
```

The specific version of the docker image is located as a variable in `.env` to be easy to update. (.env files are loaded by autoenv shell extension)

## Advice
- integrate this docker image in every ionic project
- also make sure to copy the "node_modules" somewhere in the docker image to make sure you still have the same version installed and available in time. Just copy the node_modules in a folder like ~ inside the container, and copy it to it's original location in the source code if not present.
- use this type of images when developing with online IDEs like Cloud9
- do not try to connect usb drivers and phone to the docker container (it's a pain). Just use tools like [Ionic DevApp](https://ionicframework.com/docs/pro/devapp/)