# Argus GStreamer CGo Proof of Concept

This repository is a proof of concept for the use of gstreamer with cgo for the Argus Stream Engine Service

## Usage 

install dependencies:
```
make deps 
```

NOTE: The desired nginx.conf is included at the root level of this repository for reference; check or edit /etc/nginx/nginx.conf accordingly. Then:
```
make prep
```

build pipeline library binaries:
```
make build
```

run application: 
```
go run main.go
```

remove stale binaries:
```
make clean
```