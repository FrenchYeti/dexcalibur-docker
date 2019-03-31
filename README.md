# dexcalibur-docker
A quick way to test Dexcalibur 

## Quick start 

Get the container

```
docker pull frenchyeti/dexcalibur:latest
```

If your rooted device is connected (by USB) and the targeted app <TARGET> install on this device. 
Use the following command :
  
```
docker run -a stdout -p 8080:8000 -v <YOUR_WORKSPACE_PATH>:/home/dexcalibur/workspace --app=<TARGET> --pull
```

Else, if you have alreay a dexcalibur workspace remove the `--pull`at the end.

## Troublesooting

### The USB is not detected by my container 
 
TODO 
