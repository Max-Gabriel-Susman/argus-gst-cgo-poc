package main

/*
#cgo pkg-config: gstreamer-1.0
#cgo CFLAGS: -I.
#cgo LDFLAGS: -L. -lgst_pipeline
#include "gst_pipeline.h"
*/
import "C"
import "fmt"

func main() {
	fmt.Println("Initializing GStreamer from Go...")
	C.init_gstreamer()

	// Example pipeline: a test video source that shows a test pattern
	pipelineStr := C.CString("videotestsrc ! autovideosink")

	fmt.Println("Starting pipeline...")
	// This call will block until the pipeline is stopped (in C)
	go func() {
		// Wait a bit, then stop
		// (In a real app, you'd likely wait on some condition or signal)
		// time.Sleep(10 * time.Second)
		// C.stop_pipeline()
	}()
	C.start_pipeline(pipelineStr)

	fmt.Println("Pipeline stopped.")
}
