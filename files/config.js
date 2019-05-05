module.exports = {
    // the default encoding ()
    encoding: "utf8",// "ascii",

    // Dexcalibur src location
    dexcaliburPath: "/home/dexcalibur/dexcalibur/src/",
    
    // workspace location : folder where analyzed APK and data are stored
    workspacePath: "/home/dexcalibur/workspace/", 
    
    // ADB location
    adbPath: "/home/dexcalibur/platform-tools/platform-tools/adb",
    // androidSdkPath is useless for this Docker image (Android SDK not installed)
    androidSdkPath: "/home/dexcalibur/platform-tools/",

    // APKTool location
    apktPath: "/usr/local/bin/apktool",//"/home/dexcalibur/apktool",

    // Optional : SDB location
    sdbPath: null,

    // TODO useless : to remove
    fridaDevPath: "/data/local/frida-server",
    fridaServerPath: "",
    
    // do not modified
    deviceId: null,
    useEmulator: false,

    // temporary files location
    tmpDir: "/tmp/",

    // default bridge
    bridge: "adb",

    // Default web server config
    web_port: 8000,

    
    // Android API version 
    platform_target: "android:7.0.0",

    // additional platforms can be add here
    platform_available: {
        "android:7.0.0": {
            name: "android",
            version : "7.0.0",
            apiVersion: 24,
            // Default path is APIS/<name>_<apiVersion> 
            // Custom path can be defined as follow
            // binaryPath: "/tmp/android_custom/"
        }
    }
};
