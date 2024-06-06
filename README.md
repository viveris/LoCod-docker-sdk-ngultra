# LoCod docker sdk NG-Ultra

## Description

This repository contains a Dockerfile to make a Docker image with the followings components :

- **NG-Ultra BSP** : the NG-Ultra BSP corresponds to a Git repository containing everything needed to develop CPU code for NG-Ultra target. This includes nxbuilder, the build system for NG-Ultra, drivers specific to the chip's CPU architecture, and various example applications for testing the board's components (DDR, LEDs, GPIOs, etc.)

In the context of the Locod project, this SDK is used to generate the executable from the user C code for the NG-Ultra target board.

<br>

## Dependencies

To build the Docker image, it is necessary to have credits on the NanoXplore GitLab to access the **ngultra_bsp** repository:
- **NX_USERNAME** : username on the NanoXplore Gitlab
- **NX_PERSONAL_ACCESS_TOKEN** : Personal Access Token generated on the NanoXplore Gitlab to have the rights to pull the repository with https.

<br>

## Image build

Assuming that the credits for Gitlab Nanoxplore are defined by the **$NX_USERNAME** and **$NX_PERSONAL_ACCESS_TOKEN** variables, the Docker image can then be built using the following command:

```console
docker build -t ${IMG_NAME} --build-arg NX_USERNAME=${NX_USERNAME} --build-arg NX_PERSONAL_ACCESS_TOKEN=${NX_PERSONAL_ACCESS_TOKEN} -f Dockerfile .
```

<br>

## Run command and usage

Inside the image, the NG-Ultra BSP is installed in **/opt/ngultra_bsp**. By default, the launch directory (docker WORKDIR) is defined in **/opt/ngultra_bsp/apps/locod**. The built docker image can then be launched with C code files (sources and Makefile) binded to this folder, in order to build the executable with this BSP.

The Docker image can be launched with the following command:
```console
docker run -it --rm -u $(id -u):$(id -g) -v ... ${IMG_NAME}
```
