# Argus GStreamer CGo Proof of Concept

This repository is a proof of concept for the use of gstreamer with cgo for the Argus Stream Engine Service

## Usage 

compile C files:
```
make cmpl-c
```

create C library:
```
make create-lib
```

run application: 
```
go run main.go
```