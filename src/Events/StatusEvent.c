/* StatusEvent.c generated by valac 0.12.0, the Vala compiler
 * generated from StatusEvent.vala, do not modify */

/*SemesterLeistung - An IRC Daemon
* Copyright (C) 2011  Simon Baumer
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>


#define DAEMON_EVENTS_TYPE_STATUS_CHANGE (daemon_events_status_change_get_type ())

#define DAEMON_EVENTS_TYPE_LOG_EVENT (daemon_events_log_event_get_type ())
#define DAEMON_EVENTS_LOG_EVENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_EVENTS_TYPE_LOG_EVENT, DaemonEventsLogEvent))
#define DAEMON_EVENTS_LOG_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), DAEMON_EVENTS_TYPE_LOG_EVENT, DaemonEventsLogEventClass))
#define DAEMON_EVENTS_IS_LOG_EVENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_EVENTS_TYPE_LOG_EVENT))
#define DAEMON_EVENTS_IS_LOG_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), DAEMON_EVENTS_TYPE_LOG_EVENT))
#define DAEMON_EVENTS_LOG_EVENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), DAEMON_EVENTS_TYPE_LOG_EVENT, DaemonEventsLogEventClass))

typedef struct _DaemonEventsLogEvent DaemonEventsLogEvent;
typedef struct _DaemonEventsLogEventClass DaemonEventsLogEventClass;
typedef struct _DaemonEventsLogEventPrivate DaemonEventsLogEventPrivate;

#define DAEMON_EVENTS_TYPE_STATUS_EVENT (daemon_events_status_event_get_type ())
#define DAEMON_EVENTS_STATUS_EVENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_EVENTS_TYPE_STATUS_EVENT, DaemonEventsStatusEvent))
#define DAEMON_EVENTS_STATUS_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), DAEMON_EVENTS_TYPE_STATUS_EVENT, DaemonEventsStatusEventClass))
#define DAEMON_EVENTS_IS_STATUS_EVENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_EVENTS_TYPE_STATUS_EVENT))
#define DAEMON_EVENTS_IS_STATUS_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), DAEMON_EVENTS_TYPE_STATUS_EVENT))
#define DAEMON_EVENTS_STATUS_EVENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), DAEMON_EVENTS_TYPE_STATUS_EVENT, DaemonEventsStatusEventClass))

typedef struct _DaemonEventsStatusEvent DaemonEventsStatusEvent;
typedef struct _DaemonEventsStatusEventClass DaemonEventsStatusEventClass;
typedef struct _DaemonEventsStatusEventPrivate DaemonEventsStatusEventPrivate;
#define _g_free0(var) (var = (g_free (var), NULL))

typedef enum  {
	DAEMON_EVENTS_STATUS_CHANGE_Join,
	DAEMON_EVENTS_STATUS_CHANGE_Leave
} DaemonEventsStatusChange;

struct _DaemonEventsLogEvent {
	GObject parent_instance;
	DaemonEventsLogEventPrivate * priv;
};

struct _DaemonEventsLogEventClass {
	GObjectClass parent_class;
	gchar* (*ToString) (DaemonEventsLogEvent* self);
};

struct _DaemonEventsStatusEvent {
	DaemonEventsLogEvent parent_instance;
	DaemonEventsStatusEventPrivate * priv;
};

struct _DaemonEventsStatusEventClass {
	DaemonEventsLogEventClass parent_class;
};

struct _DaemonEventsStatusEventPrivate {
	DaemonEventsStatusChange _Type;
};


static gpointer daemon_events_status_event_parent_class = NULL;

GType daemon_events_status_change_get_type (void) G_GNUC_CONST;
GType daemon_events_log_event_get_type (void) G_GNUC_CONST;
GType daemon_events_status_event_get_type (void) G_GNUC_CONST;
#define DAEMON_EVENTS_STATUS_EVENT_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), DAEMON_EVENTS_TYPE_STATUS_EVENT, DaemonEventsStatusEventPrivate))
enum  {
	DAEMON_EVENTS_STATUS_EVENT_DUMMY_PROPERTY,
	DAEMON_EVENTS_STATUS_EVENT_TYPE
};
#define DAEMON_EVENTS_STATUS_EVENT__stringFormat "%s | User '%s' on '%s' %s Channel '%s'"
DaemonEventsStatusEvent* daemon_events_status_event_new (const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server);
DaemonEventsStatusEvent* daemon_events_status_event_construct (GType object_type, const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server);
DaemonEventsLogEvent* daemon_events_log_event_construct (GType object_type, const gchar* username, const gchar* channel, const gchar* server);
static void daemon_events_status_event_set_Type (DaemonEventsStatusEvent* self, DaemonEventsStatusChange value);
DaemonEventsStatusEvent* daemon_events_status_event_new_WithTimestamp (const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server, GDateTime* timestamp);
DaemonEventsStatusEvent* daemon_events_status_event_construct_WithTimestamp (GType object_type, const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server, GDateTime* timestamp);
DaemonEventsLogEvent* daemon_events_log_event_construct_WithTimestamp (GType object_type, const gchar* username, const gchar* channel, const gchar* server, GDateTime* timestamp);
static gchar* daemon_events_status_event_real_ToString (DaemonEventsLogEvent* base);
DaemonEventsStatusChange daemon_events_status_event_get_Type (DaemonEventsStatusEvent* self);
const gchar* daemon_events_log_event_get_TimestampString (DaemonEventsLogEvent* self);
const gchar* daemon_events_log_event_get_Username (DaemonEventsLogEvent* self);
const gchar* daemon_events_log_event_get_Server (DaemonEventsLogEvent* self);
const gchar* daemon_events_log_event_get_Channel (DaemonEventsLogEvent* self);
static void daemon_events_status_event_finalize (GObject* obj);
static void _vala_daemon_events_status_event_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void _vala_daemon_events_status_event_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);


GType daemon_events_status_change_get_type (void) {
	static volatile gsize daemon_events_status_change_type_id__volatile = 0;
	if (g_once_init_enter (&daemon_events_status_change_type_id__volatile)) {
		static const GEnumValue values[] = {{DAEMON_EVENTS_STATUS_CHANGE_Join, "DAEMON_EVENTS_STATUS_CHANGE_Join", "join"}, {DAEMON_EVENTS_STATUS_CHANGE_Leave, "DAEMON_EVENTS_STATUS_CHANGE_Leave", "leave"}, {0, NULL, NULL}};
		GType daemon_events_status_change_type_id;
		daemon_events_status_change_type_id = g_enum_register_static ("DaemonEventsStatusChange", values);
		g_once_init_leave (&daemon_events_status_change_type_id__volatile, daemon_events_status_change_type_id);
	}
	return daemon_events_status_change_type_id__volatile;
}


DaemonEventsStatusEvent* daemon_events_status_event_construct (GType object_type, const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server) {
	DaemonEventsStatusEvent * self = NULL;
	g_return_val_if_fail (username != NULL, NULL);
	g_return_val_if_fail (channel != NULL, NULL);
	g_return_val_if_fail (server != NULL, NULL);
	self = (DaemonEventsStatusEvent*) daemon_events_log_event_construct (object_type, username, channel, server);
	daemon_events_status_event_set_Type (self, type);
	return self;
}


DaemonEventsStatusEvent* daemon_events_status_event_new (const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server) {
	return daemon_events_status_event_construct (DAEMON_EVENTS_TYPE_STATUS_EVENT, username, type, channel, server);
}


DaemonEventsStatusEvent* daemon_events_status_event_construct_WithTimestamp (GType object_type, const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server, GDateTime* timestamp) {
	DaemonEventsStatusEvent * self = NULL;
	g_return_val_if_fail (username != NULL, NULL);
	g_return_val_if_fail (channel != NULL, NULL);
	g_return_val_if_fail (server != NULL, NULL);
	g_return_val_if_fail (timestamp != NULL, NULL);
	self = (DaemonEventsStatusEvent*) daemon_events_log_event_construct_WithTimestamp (object_type, username, channel, server, timestamp);
	daemon_events_status_event_set_Type (self, type);
	return self;
}


DaemonEventsStatusEvent* daemon_events_status_event_new_WithTimestamp (const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server, GDateTime* timestamp) {
	return daemon_events_status_event_construct_WithTimestamp (DAEMON_EVENTS_TYPE_STATUS_EVENT, username, type, channel, server, timestamp);
}


static gchar* daemon_events_status_event_real_ToString (DaemonEventsLogEvent* base) {
	DaemonEventsStatusEvent * self;
	gchar* result = NULL;
	const gchar* _tmp0_ = NULL;
	gchar* _tmp1_;
	gchar* eventString;
	const gchar* _tmp2_ = NULL;
	const gchar* _tmp3_ = NULL;
	const gchar* _tmp4_ = NULL;
	const gchar* _tmp5_ = NULL;
	gchar* _tmp6_ = NULL;
	self = (DaemonEventsStatusEvent*) base;
	if (self->priv->_Type == DAEMON_EVENTS_STATUS_CHANGE_Join) {
		_tmp0_ = "joined";
	} else {
		_tmp0_ = "left";
	}
	_tmp1_ = g_strdup (_tmp0_);
	eventString = _tmp1_;
	_tmp2_ = daemon_events_log_event_get_TimestampString ((DaemonEventsLogEvent*) self);
	_tmp3_ = daemon_events_log_event_get_Username ((DaemonEventsLogEvent*) self);
	_tmp4_ = daemon_events_log_event_get_Server ((DaemonEventsLogEvent*) self);
	_tmp5_ = daemon_events_log_event_get_Channel ((DaemonEventsLogEvent*) self);
	_tmp6_ = g_strdup_printf (DAEMON_EVENTS_STATUS_EVENT__stringFormat, _tmp2_, _tmp3_, _tmp4_, eventString, _tmp5_);
	result = _tmp6_;
	_g_free0 (eventString);
	return result;
}


DaemonEventsStatusChange daemon_events_status_event_get_Type (DaemonEventsStatusEvent* self) {
	DaemonEventsStatusChange result;
	g_return_val_if_fail (self != NULL, 0);
	result = self->priv->_Type;
	return result;
}


static void daemon_events_status_event_set_Type (DaemonEventsStatusEvent* self, DaemonEventsStatusChange value) {
	g_return_if_fail (self != NULL);
	self->priv->_Type = value;
	g_object_notify ((GObject *) self, "Type");
}


static void daemon_events_status_event_class_init (DaemonEventsStatusEventClass * klass) {
	daemon_events_status_event_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (DaemonEventsStatusEventPrivate));
	DAEMON_EVENTS_LOG_EVENT_CLASS (klass)->ToString = daemon_events_status_event_real_ToString;
	G_OBJECT_CLASS (klass)->get_property = _vala_daemon_events_status_event_get_property;
	G_OBJECT_CLASS (klass)->set_property = _vala_daemon_events_status_event_set_property;
	G_OBJECT_CLASS (klass)->finalize = daemon_events_status_event_finalize;
	g_object_class_install_property (G_OBJECT_CLASS (klass), DAEMON_EVENTS_STATUS_EVENT_TYPE, g_param_spec_enum ("Type", "Type", "Type", DAEMON_EVENTS_TYPE_STATUS_CHANGE, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE));
}


static void daemon_events_status_event_instance_init (DaemonEventsStatusEvent * self) {
	self->priv = DAEMON_EVENTS_STATUS_EVENT_GET_PRIVATE (self);
}


static void daemon_events_status_event_finalize (GObject* obj) {
	DaemonEventsStatusEvent * self;
	self = DAEMON_EVENTS_STATUS_EVENT (obj);
	G_OBJECT_CLASS (daemon_events_status_event_parent_class)->finalize (obj);
}


GType daemon_events_status_event_get_type (void) {
	static volatile gsize daemon_events_status_event_type_id__volatile = 0;
	if (g_once_init_enter (&daemon_events_status_event_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (DaemonEventsStatusEventClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) daemon_events_status_event_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (DaemonEventsStatusEvent), 0, (GInstanceInitFunc) daemon_events_status_event_instance_init, NULL };
		GType daemon_events_status_event_type_id;
		daemon_events_status_event_type_id = g_type_register_static (DAEMON_EVENTS_TYPE_LOG_EVENT, "DaemonEventsStatusEvent", &g_define_type_info, 0);
		g_once_init_leave (&daemon_events_status_event_type_id__volatile, daemon_events_status_event_type_id);
	}
	return daemon_events_status_event_type_id__volatile;
}


static void _vala_daemon_events_status_event_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	DaemonEventsStatusEvent * self;
	self = DAEMON_EVENTS_STATUS_EVENT (object);
	switch (property_id) {
		case DAEMON_EVENTS_STATUS_EVENT_TYPE:
		g_value_set_enum (value, daemon_events_status_event_get_Type (self));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void _vala_daemon_events_status_event_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	DaemonEventsStatusEvent * self;
	self = DAEMON_EVENTS_STATUS_EVENT (object);
	switch (property_id) {
		case DAEMON_EVENTS_STATUS_EVENT_TYPE:
		daemon_events_status_event_set_Type (self, g_value_get_enum (value));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}



