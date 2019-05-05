# dexcalibur-docker

A quick way to discover Dexcalibur without no more requirements.

*If you expect to often use Dexcalibur, i encourage you to install it instead of use a Docker container.
It will be easier to configure and the USB communication will be more stable. Finally, its performance seems higher.*

## 1. Quick start 

Pull the image

```
docker pull frenchyeti/dexcalibur:latest
```

### Case 1 : From an application installed on the device 

**If you expect to deploy hooks, your device need to be rooted.**

If your rooted device is connected (by USB) and the targeted app <TARGET> install on this device. 
Use the following command :
  
```
$ docker run -it -p 8080:8000 -v <YOUR_WORKSPACE_PATH>:/home/dexcalibur/workspace dexcalibur
# ./dexcalibur --app=<TARGET> --pull
```

Else, if you have already a dexcalibur workspace remove the `--pull`at the end.


### Case 2 : From the APK file

If you have the APK file, you have several possibilities :

#### If the APK file is already in the workspace volume

```
$ docker run -it -p 8080:8000 -v <YOUR_WORKSPACE_PATH>:/home/dexcalibur/workspace dexcalibur
# ./dexcalibur --app=<TARGET> --apk=<ABSOLUTE_PATH_TO_YOUR_APK>
```

#### By copying it from the host to the container

Run the docker image :
```
$ docker run -it -p 8080:8000 -v <YOUR_WORKSPACE_PATH>:/home/dexcalibur/workspace dexcalibur
```

From the host, copy the APK file to the container filesystem :
```
$ docker cp <local> <dest>
```

Finally, start dexcalibur by specifying the absolute path to the targeted APK.
```
# ./dexcalibur --app=<TARGET> --apk=<ABSOLUTE_PATH_TO_YOUR_APK>
```


#### If the APK file is already in the workspace volume

```
$ docker run -it -p 8080:8000 -v <YOUR_WORKSPACE_PATH>:/home/dexcalibur/workspace dexcalibur
# ./dexcalibur --app=<TARGET> --apk=<ABSOLUTE_PATH_TO_YOUR_APK>
```



## 2. Troublesooting

### The USB is not detected by my container 
 
TODO 
