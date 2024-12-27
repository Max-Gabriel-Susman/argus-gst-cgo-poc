package main

/*
#cgo CFLAGS: -I.
#cgo LDFLAGS: -L. -lpipeline
#include "../../pipeline.h"
*/
import "C"

func main() {
	C.InitializeMediaPipeline()
}
