#ifndef GST_PIPELINE_H
#define GST_PIPELINE_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Initializes the GStreamer library (gst_init).
 */
void init_gstreamer(void);

/**
 * Starts a GStreamer pipeline from the given launch string and
 * blocks until the pipeline is stopped or an error/EOS occurs.
 *
 * @param pipelineStr A GStreamer launch pipeline (e.g., receiving RTMP, streaming out RTMP).
 */
void start_rtmp_forwarding(const char *pipelineStr);

/**
 * Stops the currently running GStreamer pipeline by quitting its main loop.
 */
void stop_pipeline(void);

#ifdef __cplusplus
}
#endif

#endif // GST_PIPELINE_H
