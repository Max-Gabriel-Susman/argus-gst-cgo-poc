package main

/*
#cgo pkg-config: gstreamer-1.0
// Include the .c file so CGO compiles/links it:
#include "gst_pipeline.c"
*/
import "C"

import (
	"fmt"
	"time"
	"unsafe"
)

func main() {
	fmt.Println("Initializing GStreamer from Go...")
	C.init_gstreamer()

	// Example pipeline:
	//  - Receives RTMP stream at rtmp://0.0.0.0:1935/incoming/stream
	//  - Splits into audio/video with flvdemux
	//  - Parses them (h264parse, aacparse)
	//  - Re-muxes them with flvmux
	//  - Pushes out to rtmp://0.0.0.0:1935/outgoing/stream
	pipelineStr := `
        rtmpsrc location="rtmp://0.0.0.0:1935/incoming/stream" !
        flvdemux name=demux
        demux.video ! queue ! h264parse ! mux.
        demux.audio ! queue ! aacparse ! mux.
        flvmux name=mux !
        rtmpsink location="rtmp://0.0.0.0:1935/outgoing/stream"
    `

	cPipeline := C.CString(pipelineStr)
	defer C.free(unsafe.Pointer(cPipeline))

	fmt.Println("Starting RTMP forwarding pipeline...")
	// Start the pipeline in the current goroutine (blocks until stopped)
	go func() {
		// For demonstration, we'll stop the pipeline after 30 seconds
		time.Sleep(30 * time.Second)
		fmt.Println("Stopping pipeline...")
		C.stop_pipeline()
	}()

	// This call blocks until we call C.stop_pipeline() or an error/EOS occurs
	C.start_rtmp_forwarding(cPipeline)

	fmt.Println("Pipeline stopped. Exiting.")
}
