#include <gst/gst.h>
#include <glib.h>

// Global pointer to GMainLoop, so we can stop it later if needed
static GMainLoop *loop = NULL;

void init_gstreamer() {
    // Initialize GStreamer
    gst_init(NULL, NULL);
}

void start_pipeline(const char *pipelineStr) {
    GstElement *pipeline = gst_parse_launch(pipelineStr, NULL);

    if (!pipeline) {
        g_printerr("Failed to create pipeline from string.\n");
        return;
    }

    // Create a main loop
    loop = g_main_loop_new(NULL, FALSE);

    // For completeness, attach a bus watch to handle messages
    GstBus *bus = gst_element_get_bus(pipeline);
    gst_bus_add_watch(bus, (GstBusFunc)gst_bus_async_signal_func, NULL);
    gst_object_unref(bus);

    // Set pipeline to PLAYING
    gst_element_set_state(pipeline, GST_STATE_PLAYING);

    // Run the main loop
    g_main_loop_run(loop);

    // Cleanup after main loop finishes
    gst_element_set_state(pipeline, GST_STATE_NULL);
    gst_object_unref(pipeline);
    g_main_loop_unref(loop);
    loop = NULL;
}

void stop_pipeline() {
    if (loop) {
        g_main_loop_quit(loop);
    }
}
