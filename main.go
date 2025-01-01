package main

/*
#cgo pkg-config: gstreamer-1.0
#include "gst_pipeline.c"
*/
import "C"

import (
	"fmt"
	"unsafe"
)

func main() {
	fmt.Println("Initializing GStreamer from Go...")
	C.init_gstreamer()

	pipelineStr := `
        rtmpsrc location="rtmp://localhost/incoming/myStream" !
        flvdemux name=demux
        demux.video ! queue ! h264parse ! mux.
        demux.audio ! queue ! aacparse ! mux.
        flvmux name=mux !
        rtmpsink location="rtmp://localhost/outgoing/myRestream"
    `
	cPipeline := C.CString(pipelineStr)
	defer C.free(unsafe.Pointer(cPipeline))

	fmt.Println("Starting RTMP forwarding pipeline...")

	// For demo, we'll stop after 60 seconds
	// go func() {
	// 	time.Sleep(60 * time.Second)
	// 	fmt.Println("Stopping pipeline...")
	// 	C.stop_pipeline()
	// }()

	// This blocks until we call stop_pipeline or pipeline hits error/EOS
	C.start_rtmp_forwarding(cPipeline)

	fmt.Println("Pipeline stopped. Exiting.")
}
