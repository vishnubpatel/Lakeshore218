#!../../bin/linux-x86_64/ls218

#- You may have to change ls218 to something else
#- everywhere it appears in this file
#system "sudo  chmod 666 /dev/gpib0"
#system "sudo ln -s /usb/local/lib/libgpib.so.0 /lib/libgpib.so.0"
#system "sudo gpib_config"

< envPaths

epicsEnvSet(STREAM_PROTOCOL_PATH, "../../ls218App/Db")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/ls218.dbd"
ls218_registerRecordDeviceDriver pdbbase

## 2 Configure your asynPorts
# 2a GPIB: portname, autoConnect, boardId, timeout, 5th_arg
     GpibBoardDriverConfig("agi", "1", "0", "3", "0")

## Load record instances
dbLoadTemplate "db/user.substitutions"
dbLoadRecords "db/ls218Version.db", "user=vishnu"
dbLoadRecords "db/dbSubExample.db", "user=vishnu"
#dbLoadRecords "db/ls218.substitutions"

#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=vishnu"
