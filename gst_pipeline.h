#ifndef GST_PIPELINE_H
#define GST_PIPELINE_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Initializes the GStreamer library.
 */
void init_gstreamer(void);

/**
 * Parses and starts a GStreamer pipeline from the provided string.
 * This function blocks until the pipeline is stopped (or hits an error/EOS).
 *
 * \param pipelineStr - A GStreamer launch string (e.g., "videotestsrc ! autovideosink").
 */
void start_pipeline(const char *pipelineStr);

/**
 * Stops the currently running GStreamer pipeline and quits the main loop.
 */
void stop_pipeline(void);

#ifdef __cplusplus
}
#endif

#endif // GST_PIPELINE_H
