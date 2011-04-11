/* IEvent.c generated by valac 0.12.0, the Vala compiler
 * generated from IEvent.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>


#define DAEMON_EVENTS_TYPE_IEVENT (daemon_events_ievent_get_type ())
#define DAEMON_EVENTS_IEVENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_EVENTS_TYPE_IEVENT, DaemonEventsIEvent))
#define DAEMON_EVENTS_IS_IEVENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_EVENTS_TYPE_IEVENT))
#define DAEMON_EVENTS_IEVENT_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), DAEMON_EVENTS_TYPE_IEVENT, DaemonEventsIEventIface))

typedef struct _DaemonEventsIEvent DaemonEventsIEvent;
typedef struct _DaemonEventsIEventIface DaemonEventsIEventIface;

struct _DaemonEventsIEventIface {
	GTypeInterface parent_iface;
	const gchar* (*get_Username) (DaemonEventsIEvent* self);
	GDateTime* (*get_Timestamp) (DaemonEventsIEvent* self);
};



GType daemon_events_ievent_get_type (void) G_GNUC_CONST;
const gchar* daemon_events_ievent_get_Username (DaemonEventsIEvent* self);
GDateTime* daemon_events_ievent_get_Timestamp (DaemonEventsIEvent* self);


const gchar* daemon_events_ievent_get_Username (DaemonEventsIEvent* self) {
	return DAEMON_EVENTS_IEVENT_GET_INTERFACE (self)->get_Username (self);
}


GDateTime* daemon_events_ievent_get_Timestamp (DaemonEventsIEvent* self) {
	return DAEMON_EVENTS_IEVENT_GET_INTERFACE (self)->get_Timestamp (self);
}


static void daemon_events_ievent_base_init (DaemonEventsIEventIface * iface) {
	static gboolean initialized = FALSE;
	if (!initialized) {
		initialized = TRUE;
		g_object_interface_install_property (iface, g_param_spec_string ("Username", "Username", "Username", NULL, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE));
		g_object_interface_install_property (iface, g_param_spec_boxed ("Timestamp", "Timestamp", "Timestamp", G_TYPE_DATE_TIME, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE));
	}
}


GType daemon_events_ievent_get_type (void) {
	static volatile gsize daemon_events_ievent_type_id__volatile = 0;
	if (g_once_init_enter (&daemon_events_ievent_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (DaemonEventsIEventIface), (GBaseInitFunc) daemon_events_ievent_base_init, (GBaseFinalizeFunc) NULL, (GClassInitFunc) NULL, (GClassFinalizeFunc) NULL, NULL, 0, 0, (GInstanceInitFunc) NULL, NULL };
		GType daemon_events_ievent_type_id;
		daemon_events_ievent_type_id = g_type_register_static (G_TYPE_INTERFACE, "DaemonEventsIEvent", &g_define_type_info, 0);
		g_type_interface_add_prerequisite (daemon_events_ievent_type_id, G_TYPE_OBJECT);
		g_once_init_leave (&daemon_events_ievent_type_id__volatile, daemon_events_ievent_type_id);
	}
	return daemon_events_ievent_type_id__volatile;
}


