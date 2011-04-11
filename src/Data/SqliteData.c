/* SqliteData.c generated by valac 0.12.0, the Vala compiler
 * generated from SqliteData.vala, do not modify */

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
#include <sqlite3.h>


#define DAEMON_DATA_TYPE_IDATA_ACCESS (daemon_data_idata_access_get_type ())
#define DAEMON_DATA_IDATA_ACCESS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_DATA_TYPE_IDATA_ACCESS, DaemonDataIDataAccess))
#define DAEMON_DATA_IS_IDATA_ACCESS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_DATA_TYPE_IDATA_ACCESS))
#define DAEMON_DATA_IDATA_ACCESS_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), DAEMON_DATA_TYPE_IDATA_ACCESS, DaemonDataIDataAccessIface))

typedef struct _DaemonDataIDataAccess DaemonDataIDataAccess;
typedef struct _DaemonDataIDataAccessIface DaemonDataIDataAccessIface;

#define DAEMON_EVENTS_TYPE_LOG_EVENT (daemon_events_log_event_get_type ())
#define DAEMON_EVENTS_LOG_EVENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_EVENTS_TYPE_LOG_EVENT, DaemonEventsLogEvent))
#define DAEMON_EVENTS_LOG_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), DAEMON_EVENTS_TYPE_LOG_EVENT, DaemonEventsLogEventClass))
#define DAEMON_EVENTS_IS_LOG_EVENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_EVENTS_TYPE_LOG_EVENT))
#define DAEMON_EVENTS_IS_LOG_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), DAEMON_EVENTS_TYPE_LOG_EVENT))
#define DAEMON_EVENTS_LOG_EVENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), DAEMON_EVENTS_TYPE_LOG_EVENT, DaemonEventsLogEventClass))

typedef struct _DaemonEventsLogEvent DaemonEventsLogEvent;
typedef struct _DaemonEventsLogEventClass DaemonEventsLogEventClass;

#define DAEMON_DATA_TYPE_SQLITE_DATA (daemon_data_sqlite_data_get_type ())
#define DAEMON_DATA_SQLITE_DATA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_DATA_TYPE_SQLITE_DATA, DaemonDataSqliteData))
#define DAEMON_DATA_SQLITE_DATA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), DAEMON_DATA_TYPE_SQLITE_DATA, DaemonDataSqliteDataClass))
#define DAEMON_DATA_IS_SQLITE_DATA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_DATA_TYPE_SQLITE_DATA))
#define DAEMON_DATA_IS_SQLITE_DATA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), DAEMON_DATA_TYPE_SQLITE_DATA))
#define DAEMON_DATA_SQLITE_DATA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), DAEMON_DATA_TYPE_SQLITE_DATA, DaemonDataSqliteDataClass))

typedef struct _DaemonDataSqliteData DaemonDataSqliteData;
typedef struct _DaemonDataSqliteDataClass DaemonDataSqliteDataClass;
typedef struct _DaemonDataSqliteDataPrivate DaemonDataSqliteDataPrivate;
#define _sqlite3_close0(var) ((var == NULL) ? NULL : (var = (sqlite3_close (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))

#define DAEMON_TYPE_CONSOLE_COLORS (daemon_console_colors_get_type ())

#define DAEMON_EVENTS_TYPE_STATUS_EVENT (daemon_events_status_event_get_type ())
#define DAEMON_EVENTS_STATUS_EVENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_EVENTS_TYPE_STATUS_EVENT, DaemonEventsStatusEvent))
#define DAEMON_EVENTS_STATUS_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), DAEMON_EVENTS_TYPE_STATUS_EVENT, DaemonEventsStatusEventClass))
#define DAEMON_EVENTS_IS_STATUS_EVENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_EVENTS_TYPE_STATUS_EVENT))
#define DAEMON_EVENTS_IS_STATUS_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), DAEMON_EVENTS_TYPE_STATUS_EVENT))
#define DAEMON_EVENTS_STATUS_EVENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), DAEMON_EVENTS_TYPE_STATUS_EVENT, DaemonEventsStatusEventClass))

typedef struct _DaemonEventsStatusEvent DaemonEventsStatusEvent;
typedef struct _DaemonEventsStatusEventClass DaemonEventsStatusEventClass;

#define DAEMON_EVENTS_TYPE_CHANGE_NAME_EVENT (daemon_events_change_name_event_get_type ())
#define DAEMON_EVENTS_CHANGE_NAME_EVENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_EVENTS_TYPE_CHANGE_NAME_EVENT, DaemonEventsChangeNameEvent))
#define DAEMON_EVENTS_CHANGE_NAME_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), DAEMON_EVENTS_TYPE_CHANGE_NAME_EVENT, DaemonEventsChangeNameEventClass))
#define DAEMON_EVENTS_IS_CHANGE_NAME_EVENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_EVENTS_TYPE_CHANGE_NAME_EVENT))
#define DAEMON_EVENTS_IS_CHANGE_NAME_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), DAEMON_EVENTS_TYPE_CHANGE_NAME_EVENT))
#define DAEMON_EVENTS_CHANGE_NAME_EVENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), DAEMON_EVENTS_TYPE_CHANGE_NAME_EVENT, DaemonEventsChangeNameEventClass))

typedef struct _DaemonEventsChangeNameEvent DaemonEventsChangeNameEvent;
typedef struct _DaemonEventsChangeNameEventClass DaemonEventsChangeNameEventClass;

#define DAEMON_EVENTS_TYPE_MESSAGE_EVENT (daemon_events_message_event_get_type ())
#define DAEMON_EVENTS_MESSAGE_EVENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_EVENTS_TYPE_MESSAGE_EVENT, DaemonEventsMessageEvent))
#define DAEMON_EVENTS_MESSAGE_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), DAEMON_EVENTS_TYPE_MESSAGE_EVENT, DaemonEventsMessageEventClass))
#define DAEMON_EVENTS_IS_MESSAGE_EVENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_EVENTS_TYPE_MESSAGE_EVENT))
#define DAEMON_EVENTS_IS_MESSAGE_EVENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), DAEMON_EVENTS_TYPE_MESSAGE_EVENT))
#define DAEMON_EVENTS_MESSAGE_EVENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), DAEMON_EVENTS_TYPE_MESSAGE_EVENT, DaemonEventsMessageEventClass))

typedef struct _DaemonEventsMessageEvent DaemonEventsMessageEvent;
typedef struct _DaemonEventsMessageEventClass DaemonEventsMessageEventClass;
#define _sqlite3_finalize0(var) ((var == NULL) ? NULL : (var = (sqlite3_finalize (var), NULL)))

#define DAEMON_EVENTS_TYPE_STATUS_CHANGE (daemon_events_status_change_get_type ())

#define DAEMON_DATA_TYPE_EVENT_TYPES (daemon_data_event_types_get_type ())
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_date_time_unref0(var) ((var == NULL) ? NULL : (var = (g_date_time_unref (var), NULL)))
#define __g_list_free__g_object_unref0_0(var) ((var == NULL) ? NULL : (var = (_g_list_free__g_object_unref0_ (var), NULL)))

typedef enum  {
	DAEMON_DATA_DATA_ACCESS_ERROR_OpenFailed,
	DAEMON_DATA_DATA_ACCESS_ERROR_WriteError,
	DAEMON_DATA_DATA_ACCESS_ERROR_ReadError
} DaemonDataDataAccessError;
#define DAEMON_DATA_DATA_ACCESS_ERROR daemon_data_data_access_error_quark ()
struct _DaemonDataIDataAccessIface {
	GTypeInterface parent_iface;
	void (*Log) (DaemonDataIDataAccess* self, DaemonEventsLogEvent* event, GError** error);
	GDateTime* (*UserLastSeen) (DaemonDataIDataAccess* self, const gchar* username, const gchar* channel, const gchar* server, GError** error);
	GList* (*GetLog) (DaemonDataIDataAccess* self, const gchar* channel, const gchar* server, GError** error);
	void (*Init) (DaemonDataIDataAccess* self, const gchar* logPath, GError** error);
};

struct _DaemonDataSqliteData {
	GObject parent_instance;
	DaemonDataSqliteDataPrivate * priv;
};

struct _DaemonDataSqliteDataClass {
	GObjectClass parent_class;
};

struct _DaemonDataSqliteDataPrivate {
	sqlite3* _database;
};

typedef enum  {
	DAEMON_CONSOLE_COLORS_Red = 31,
	DAEMON_CONSOLE_COLORS_Green = 32,
	DAEMON_CONSOLE_COLORS_Yellow = 33,
	DAEMON_CONSOLE_COLORS_Blue = 34,
	DAEMON_CONSOLE_COLORS_Purple = 35,
	DAEMON_CONSOLE_COLORS_Cyan = 36,
	DAEMON_CONSOLE_COLORS_White = 37
} DaemonConsoleColors;

typedef enum  {
	DAEMON_EVENTS_STATUS_CHANGE_Join,
	DAEMON_EVENTS_STATUS_CHANGE_Leave
} DaemonEventsStatusChange;

typedef enum  {
	DAEMON_DATA_EVENT_TYPES_Joined = 0,
	DAEMON_DATA_EVENT_TYPES_Left = 1,
	DAEMON_DATA_EVENT_TYPES_ChangedName = 2,
	DAEMON_DATA_EVENT_TYPES_Message = 3
} DaemonDataEventTypes;


static gpointer daemon_data_sqlite_data_parent_class = NULL;
static DaemonDataIDataAccessIface* daemon_data_sqlite_data_daemon_data_idata_access_parent_iface = NULL;

GType daemon_events_log_event_get_type (void) G_GNUC_CONST;
GQuark daemon_data_data_access_error_quark (void);
GType daemon_data_idata_access_get_type (void) G_GNUC_CONST;
GType daemon_data_sqlite_data_get_type (void) G_GNUC_CONST;
#define DAEMON_DATA_SQLITE_DATA_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), DAEMON_DATA_TYPE_SQLITE_DATA, DaemonDataSqliteDataPrivate))
enum  {
	DAEMON_DATA_SQLITE_DATA_DUMMY_PROPERTY
};
static void daemon_data_sqlite_data_real_Init (DaemonDataIDataAccess* base, const gchar* logPath, GError** error);
static void daemon_data_sqlite_data_CreateSchema (DaemonDataSqliteData* self, GError** error);
GType daemon_console_colors_get_type (void) G_GNUC_CONST;
void daemon_global_log_ColorMessage (DaemonConsoleColors color, const gchar* format, ...);
static void daemon_data_sqlite_data_real_Log (DaemonDataIDataAccess* base, DaemonEventsLogEvent* event, GError** error);
GType daemon_events_status_event_get_type (void) G_GNUC_CONST;
static void daemon_data_sqlite_data_LogStatusEvent (DaemonDataSqliteData* self, DaemonEventsStatusEvent* event, GError** error);
GType daemon_events_change_name_event_get_type (void) G_GNUC_CONST;
void daemon_data_sqlite_data_LogChangeNameEvent (DaemonDataSqliteData* self, DaemonEventsChangeNameEvent* event, GError** error);
GType daemon_events_message_event_get_type (void) G_GNUC_CONST;
void daemon_data_sqlite_data_LogMessageEvent (DaemonDataSqliteData* self, DaemonEventsMessageEvent* event, GError** error);
const gchar* daemon_events_log_event_get_Username (DaemonEventsLogEvent* self);
const gchar* daemon_events_log_event_get_Channel (DaemonEventsLogEvent* self);
const gchar* daemon_events_log_event_get_Server (DaemonEventsLogEvent* self);
GType daemon_events_status_change_get_type (void) G_GNUC_CONST;
DaemonEventsStatusChange daemon_events_status_event_get_Type (DaemonEventsStatusEvent* self);
GType daemon_data_event_types_get_type (void) G_GNUC_CONST;
gint64 daemon_events_log_event_get_UnixTimestamp (DaemonEventsLogEvent* self);
const gchar* daemon_events_change_name_event_get_NewUsername (DaemonEventsChangeNameEvent* self);
const gchar* daemon_events_message_event_get_Message (DaemonEventsMessageEvent* self);
static GDateTime* daemon_data_sqlite_data_real_UserLastSeen (DaemonDataIDataAccess* base, const gchar* username, const gchar* channel, const gchar* server, GError** error);
GDateTime* daemon_helpers_date_time_converter_FromUnixTimestamp (gint64 timestamp);
static GList* daemon_data_sqlite_data_real_GetLog (DaemonDataIDataAccess* base, const gchar* channel, const gchar* server, GError** error);
DaemonEventsStatusEvent* daemon_events_status_event_new_WithTimestamp (const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server, GDateTime* timestamp);
DaemonEventsStatusEvent* daemon_events_status_event_construct_WithTimestamp (GType object_type, const gchar* username, DaemonEventsStatusChange type, const gchar* channel, const gchar* server, GDateTime* timestamp);
DaemonEventsChangeNameEvent* daemon_events_change_name_event_new_WithTimestamp (const gchar* username, const gchar* newUsername, const gchar* channel, const gchar* server, GDateTime* timestamp);
DaemonEventsChangeNameEvent* daemon_events_change_name_event_construct_WithTimestamp (GType object_type, const gchar* username, const gchar* newUsername, const gchar* channel, const gchar* server, GDateTime* timestamp);
DaemonEventsMessageEvent* daemon_events_message_event_new_WithTimestamp (const gchar* username, const gchar* message, const gchar* channel, const gchar* server, GDateTime* timestamp);
DaemonEventsMessageEvent* daemon_events_message_event_construct_WithTimestamp (GType object_type, const gchar* username, const gchar* message, const gchar* channel, const gchar* server, GDateTime* timestamp);
static void _g_object_unref0_ (gpointer var);
static void _g_list_free__g_object_unref0_ (GList* self);
DaemonDataSqliteData* daemon_data_sqlite_data_new (void);
DaemonDataSqliteData* daemon_data_sqlite_data_construct (GType object_type);
static void daemon_data_sqlite_data_finalize (GObject* obj);


static void daemon_data_sqlite_data_real_Init (DaemonDataIDataAccess* base, const gchar* logPath, GError** error) {
	DaemonDataSqliteData * self;
	gchar* _tmp0_;
	gchar* _tmp1_;
	sqlite3* _tmp3_ = NULL;
	gint _tmp4_;
	gint _result_;
	GError * _inner_error_ = NULL;
	self = (DaemonDataSqliteData*) base;
	_tmp0_ = g_strdup (logPath);
	_tmp1_ = _tmp0_;
	if (_tmp1_ == NULL) {
		gchar* _tmp2_;
		_tmp2_ = g_strdup ("data.db");
		_g_free0 (_tmp1_);
		_tmp1_ = _tmp2_;
	}
	_tmp4_ = sqlite3_open (_tmp1_, &_tmp3_);
	_sqlite3_close0 (self->priv->_database);
	self->priv->_database = _tmp3_;
	_result_ = _tmp4_;
	if (_result_ != SQLITE_OK) {
		GError* _tmp5_ = NULL;
		_tmp5_ = g_error_new_literal (DAEMON_DATA_DATA_ACCESS_ERROR, DAEMON_DATA_DATA_ACCESS_ERROR_OpenFailed, "Could not open Database");
		_inner_error_ = _tmp5_;
		if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
			g_propagate_error (error, _inner_error_);
			_g_free0 (_tmp1_);
			return;
		} else {
			_g_free0 (_tmp1_);
			g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return;
		}
	}
	daemon_data_sqlite_data_CreateSchema (self, &_inner_error_);
	if (_inner_error_ != NULL) {
		if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
			g_propagate_error (error, _inner_error_);
			_g_free0 (_tmp1_);
			return;
		} else {
			_g_free0 (_tmp1_);
			g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return;
		}
	}
	_g_free0 (_tmp1_);
}


static gint _sqlite3_exec (sqlite3* self, const gchar* sql, sqlite3_callback sqlite3_callback, void* sqlite3_callback_target, gchar** errmsg) {
	gchar* _errmsg = NULL;
	gint result = 0;
	const gchar* sqlite_errmsg = NULL;
	const gchar* _tmp0_ = NULL;
	gint _tmp1_;
	gint ec;
	g_return_val_if_fail (self != NULL, 0);
	g_return_val_if_fail (sql != NULL, 0);
	_tmp1_ = sqlite3_exec (self, sql, sqlite3_callback, sqlite3_callback_target, (char**) (&_tmp0_));
	sqlite_errmsg = _tmp0_;
	ec = _tmp1_;
	if ((&_errmsg) != NULL) {
		gchar* _tmp2_;
		_tmp2_ = g_strdup (sqlite_errmsg);
		_g_free0 (_errmsg);
		_errmsg = _tmp2_;
	}
	sqlite3_free ((void*) sqlite_errmsg);
	result = ec;
	if (errmsg) {
		*errmsg = _errmsg;
	} else {
		_g_free0 (_errmsg);
	}
	return result;
}


static void daemon_data_sqlite_data_CreateSchema (DaemonDataSqliteData* self, GError** error) {
	gchar* _tmp0_;
	gchar* createLog;
	gint _tmp1_;
	GError * _inner_error_ = NULL;
	g_return_if_fail (self != NULL);
	_tmp0_ = g_strdup ("CREATE TABLE IF NOT EXISTS Log (Username TEXT, Data TEXT NULL, Channel" \
" TEXT, Server TEXT, Timestamp INTEGER, Type INTEGER)");
	createLog = _tmp0_;
	_tmp1_ = _sqlite3_exec (self->priv->_database, createLog, NULL, NULL, NULL);
	if (_tmp1_ != SQLITE_OK) {
		GError* _tmp2_ = NULL;
		_tmp2_ = g_error_new_literal (DAEMON_DATA_DATA_ACCESS_ERROR, DAEMON_DATA_DATA_ACCESS_ERROR_WriteError, "Could not create Database");
		_inner_error_ = _tmp2_;
		if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
			g_propagate_error (error, _inner_error_);
			_g_free0 (createLog);
			return;
		} else {
			_g_free0 (createLog);
			g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return;
		}
	}
	daemon_global_log_ColorMessage (DAEMON_CONSOLE_COLORS_Green, "Successfully initialized Database");
	_g_free0 (createLog);
}


static void daemon_data_sqlite_data_real_Log (DaemonDataIDataAccess* base, DaemonEventsLogEvent* event, GError** error) {
	DaemonDataSqliteData * self;
	GError * _inner_error_ = NULL;
	self = (DaemonDataSqliteData*) base;
	g_return_if_fail (event != NULL);
	if (DAEMON_EVENTS_IS_STATUS_EVENT (event)) {
		daemon_data_sqlite_data_LogStatusEvent (self, DAEMON_EVENTS_STATUS_EVENT (event), &_inner_error_);
		if (_inner_error_ != NULL) {
			if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
				g_propagate_error (error, _inner_error_);
				return;
			} else {
				g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
				g_clear_error (&_inner_error_);
				return;
			}
		}
	} else {
		if (DAEMON_EVENTS_IS_CHANGE_NAME_EVENT (event)) {
			daemon_data_sqlite_data_LogChangeNameEvent (self, DAEMON_EVENTS_CHANGE_NAME_EVENT (event), &_inner_error_);
			if (_inner_error_ != NULL) {
				if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
					g_propagate_error (error, _inner_error_);
					return;
				} else {
					g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
					g_clear_error (&_inner_error_);
					return;
				}
			}
		} else {
			if (DAEMON_EVENTS_IS_MESSAGE_EVENT (event)) {
				daemon_data_sqlite_data_LogMessageEvent (self, DAEMON_EVENTS_MESSAGE_EVENT (event), &_inner_error_);
				if (_inner_error_ != NULL) {
					if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
						g_propagate_error (error, _inner_error_);
						return;
					} else {
						g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
						g_clear_error (&_inner_error_);
						return;
					}
				}
			}
		}
	}
}


static void daemon_data_sqlite_data_LogStatusEvent (DaemonDataSqliteData* self, DaemonEventsStatusEvent* event, GError** error) {
	gchar* _tmp0_;
	gchar* commandText;
	sqlite3_stmt* statement = NULL;
	sqlite3_stmt* _tmp1_ = NULL;
	const gchar* _tmp2_ = NULL;
	gchar* _tmp3_;
	const gchar* _tmp4_ = NULL;
	gchar* _tmp5_;
	const gchar* _tmp6_ = NULL;
	gchar* _tmp7_;
	gint _tmp8_ = 0;
	DaemonEventsStatusChange _tmp9_;
	gint64 _tmp10_;
	gint _tmp11_;
	GError * _inner_error_ = NULL;
	g_return_if_fail (self != NULL);
	g_return_if_fail (event != NULL);
	_tmp0_ = g_strdup ("INSERT INTO Log (Username, Channel, Server, Type, Timestamp) VALUES (@" \
"1, @2, @3, @4, @5)");
	commandText = _tmp0_;
	sqlite3_prepare_v2 (self->priv->_database, commandText, -1, &_tmp1_, NULL);
	_sqlite3_finalize0 (statement);
	statement = _tmp1_;
	_tmp2_ = daemon_events_log_event_get_Username ((DaemonEventsLogEvent*) event);
	_tmp3_ = g_strdup (_tmp2_);
	sqlite3_bind_text (statement, 1, _tmp3_, -1, g_free);
	_tmp4_ = daemon_events_log_event_get_Channel ((DaemonEventsLogEvent*) event);
	_tmp5_ = g_strdup (_tmp4_);
	sqlite3_bind_text (statement, 2, _tmp5_, -1, g_free);
	_tmp6_ = daemon_events_log_event_get_Server ((DaemonEventsLogEvent*) event);
	_tmp7_ = g_strdup (_tmp6_);
	sqlite3_bind_text (statement, 3, _tmp7_, -1, g_free);
	_tmp9_ = daemon_events_status_event_get_Type (event);
	if (_tmp9_ == DAEMON_EVENTS_STATUS_CHANGE_Join) {
		_tmp8_ = (gint) DAEMON_DATA_EVENT_TYPES_Joined;
	} else {
		_tmp8_ = (gint) DAEMON_DATA_EVENT_TYPES_Left;
	}
	sqlite3_bind_int (statement, 4, _tmp8_);
	_tmp10_ = daemon_events_log_event_get_UnixTimestamp ((DaemonEventsLogEvent*) event);
	sqlite3_bind_int64 (statement, 5, _tmp10_);
	_tmp11_ = sqlite3_step (statement);
	if (_tmp11_ != SQLITE_DONE) {
		const gchar* _tmp12_ = NULL;
		GError* _tmp13_ = NULL;
		_tmp12_ = sqlite3_errmsg (self->priv->_database);
		_tmp13_ = g_error_new_literal (DAEMON_DATA_DATA_ACCESS_ERROR, DAEMON_DATA_DATA_ACCESS_ERROR_WriteError, _tmp12_);
		_inner_error_ = _tmp13_;
		if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
			g_propagate_error (error, _inner_error_);
			_sqlite3_finalize0 (statement);
			_g_free0 (commandText);
			return;
		} else {
			_sqlite3_finalize0 (statement);
			_g_free0 (commandText);
			g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return;
		}
	}
	_sqlite3_finalize0 (statement);
	_g_free0 (commandText);
}


void daemon_data_sqlite_data_LogChangeNameEvent (DaemonDataSqliteData* self, DaemonEventsChangeNameEvent* event, GError** error) {
	gchar* _tmp0_;
	gchar* commandText;
	sqlite3_stmt* statement = NULL;
	sqlite3_stmt* _tmp1_ = NULL;
	const gchar* _tmp2_ = NULL;
	gchar* _tmp3_;
	const gchar* _tmp4_ = NULL;
	gchar* _tmp5_;
	const gchar* _tmp6_ = NULL;
	gchar* _tmp7_;
	const gchar* _tmp8_ = NULL;
	gchar* _tmp9_;
	gint64 _tmp10_;
	gint _tmp11_;
	GError * _inner_error_ = NULL;
	g_return_if_fail (self != NULL);
	g_return_if_fail (event != NULL);
	_tmp0_ = g_strdup ("INSERT INTO Log (Username, Data, Channel, Server, Type, Timestamp) VAL" \
"UES (@1, @2, @3, @4, @5, @6)");
	commandText = _tmp0_;
	sqlite3_prepare_v2 (self->priv->_database, commandText, -1, &_tmp1_, NULL);
	_sqlite3_finalize0 (statement);
	statement = _tmp1_;
	_tmp2_ = daemon_events_log_event_get_Username ((DaemonEventsLogEvent*) event);
	_tmp3_ = g_strdup (_tmp2_);
	sqlite3_bind_text (statement, 1, _tmp3_, -1, g_free);
	_tmp4_ = daemon_events_change_name_event_get_NewUsername (event);
	_tmp5_ = g_strdup (_tmp4_);
	sqlite3_bind_text (statement, 2, _tmp5_, -1, g_free);
	_tmp6_ = daemon_events_log_event_get_Channel ((DaemonEventsLogEvent*) event);
	_tmp7_ = g_strdup (_tmp6_);
	sqlite3_bind_text (statement, 3, _tmp7_, -1, g_free);
	_tmp8_ = daemon_events_log_event_get_Server ((DaemonEventsLogEvent*) event);
	_tmp9_ = g_strdup (_tmp8_);
	sqlite3_bind_text (statement, 4, _tmp9_, -1, g_free);
	sqlite3_bind_int (statement, 5, (gint) DAEMON_DATA_EVENT_TYPES_ChangedName);
	_tmp10_ = daemon_events_log_event_get_UnixTimestamp ((DaemonEventsLogEvent*) event);
	sqlite3_bind_int64 (statement, 6, _tmp10_);
	_tmp11_ = sqlite3_step (statement);
	if (_tmp11_ != SQLITE_DONE) {
		const gchar* _tmp12_ = NULL;
		GError* _tmp13_ = NULL;
		_tmp12_ = sqlite3_errmsg (self->priv->_database);
		_tmp13_ = g_error_new_literal (DAEMON_DATA_DATA_ACCESS_ERROR, DAEMON_DATA_DATA_ACCESS_ERROR_WriteError, _tmp12_);
		_inner_error_ = _tmp13_;
		if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
			g_propagate_error (error, _inner_error_);
			_sqlite3_finalize0 (statement);
			_g_free0 (commandText);
			return;
		} else {
			_sqlite3_finalize0 (statement);
			_g_free0 (commandText);
			g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return;
		}
	}
	_sqlite3_finalize0 (statement);
	_g_free0 (commandText);
}


void daemon_data_sqlite_data_LogMessageEvent (DaemonDataSqliteData* self, DaemonEventsMessageEvent* event, GError** error) {
	gchar* _tmp0_;
	gchar* commandText;
	sqlite3_stmt* statement = NULL;
	sqlite3_stmt* _tmp1_ = NULL;
	const gchar* _tmp2_ = NULL;
	gchar* _tmp3_;
	const gchar* _tmp4_ = NULL;
	gchar* _tmp5_;
	const gchar* _tmp6_ = NULL;
	gchar* _tmp7_;
	const gchar* _tmp8_ = NULL;
	gchar* _tmp9_;
	gint64 _tmp10_;
	gint _tmp11_;
	GError * _inner_error_ = NULL;
	g_return_if_fail (self != NULL);
	g_return_if_fail (event != NULL);
	_tmp0_ = g_strdup ("INSERT INTO Log (Username, Data, Channel, Server, Timestamp, Type) VAL" \
"UES (@1, @2, @3, @4, @5, @6)");
	commandText = _tmp0_;
	sqlite3_prepare_v2 (self->priv->_database, commandText, -1, &_tmp1_, NULL);
	_sqlite3_finalize0 (statement);
	statement = _tmp1_;
	_tmp2_ = daemon_events_log_event_get_Username ((DaemonEventsLogEvent*) event);
	_tmp3_ = g_strdup (_tmp2_);
	sqlite3_bind_text (statement, 1, _tmp3_, -1, g_free);
	_tmp4_ = daemon_events_message_event_get_Message (event);
	_tmp5_ = g_strdup (_tmp4_);
	sqlite3_bind_text (statement, 2, _tmp5_, -1, g_free);
	_tmp6_ = daemon_events_log_event_get_Channel ((DaemonEventsLogEvent*) event);
	_tmp7_ = g_strdup (_tmp6_);
	sqlite3_bind_text (statement, 3, _tmp7_, -1, g_free);
	_tmp8_ = daemon_events_log_event_get_Server ((DaemonEventsLogEvent*) event);
	_tmp9_ = g_strdup (_tmp8_);
	sqlite3_bind_text (statement, 4, _tmp9_, -1, g_free);
	_tmp10_ = daemon_events_log_event_get_UnixTimestamp ((DaemonEventsLogEvent*) event);
	sqlite3_bind_int64 (statement, 5, _tmp10_);
	sqlite3_bind_int (statement, 6, (gint) DAEMON_DATA_EVENT_TYPES_Message);
	_tmp11_ = sqlite3_step (statement);
	if (_tmp11_ != SQLITE_DONE) {
		const gchar* _tmp12_ = NULL;
		GError* _tmp13_ = NULL;
		_tmp12_ = sqlite3_errmsg (self->priv->_database);
		_tmp13_ = g_error_new_literal (DAEMON_DATA_DATA_ACCESS_ERROR, DAEMON_DATA_DATA_ACCESS_ERROR_WriteError, _tmp12_);
		_inner_error_ = _tmp13_;
		if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
			g_propagate_error (error, _inner_error_);
			_sqlite3_finalize0 (statement);
			_g_free0 (commandText);
			return;
		} else {
			_sqlite3_finalize0 (statement);
			_g_free0 (commandText);
			g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return;
		}
	}
	_sqlite3_finalize0 (statement);
	_g_free0 (commandText);
}


static GDateTime* daemon_data_sqlite_data_real_UserLastSeen (DaemonDataIDataAccess* base, const gchar* username, const gchar* channel, const gchar* server, GError** error) {
	DaemonDataSqliteData * self;
	GDateTime* result = NULL;
	gchar* _tmp0_;
	gchar* commandText;
	sqlite3_stmt* statement = NULL;
	sqlite3_stmt* _tmp1_ = NULL;
	gchar* _tmp2_;
	gchar* _tmp3_;
	gchar* _tmp4_;
	gint _tmp5_;
	gint _tmp6_;
	gint64 _tmp8_;
	GDateTime* _tmp9_ = NULL;
	self = (DaemonDataSqliteData*) base;
	g_return_val_if_fail (username != NULL, NULL);
	g_return_val_if_fail (channel != NULL, NULL);
	g_return_val_if_fail (server != NULL, NULL);
	_tmp0_ = g_strdup ("SELECT Timestamp,Type FROM Log WHERE Username = @1 AND Channel = @2 AN" \
"D Server = @3 ORDER BY Timestamp DESC LIMIT 1");
	commandText = _tmp0_;
	sqlite3_prepare_v2 (self->priv->_database, commandText, -1, &_tmp1_, NULL);
	_sqlite3_finalize0 (statement);
	statement = _tmp1_;
	_tmp2_ = g_strdup (username);
	sqlite3_bind_text (statement, 1, _tmp2_, -1, g_free);
	_tmp3_ = g_strdup (channel);
	sqlite3_bind_text (statement, 2, _tmp3_, -1, g_free);
	_tmp4_ = g_strdup (server);
	sqlite3_bind_text (statement, 3, _tmp4_, -1, g_free);
	_tmp5_ = sqlite3_step (statement);
	if (_tmp5_ != SQLITE_ROW) {
		result = NULL;
		_sqlite3_finalize0 (statement);
		_g_free0 (commandText);
		return result;
	}
	_tmp6_ = sqlite3_column_int (statement, 1);
	if (_tmp6_ != ((gint) DAEMON_DATA_EVENT_TYPES_Left)) {
		GDateTime* _tmp7_ = NULL;
		_tmp7_ = g_date_time_new_now_local ();
		result = _tmp7_;
		_sqlite3_finalize0 (statement);
		_g_free0 (commandText);
		return result;
	}
	_tmp8_ = sqlite3_column_int64 (statement, 0);
	_tmp9_ = daemon_helpers_date_time_converter_FromUnixTimestamp (_tmp8_);
	result = _tmp9_;
	_sqlite3_finalize0 (statement);
	_g_free0 (commandText);
	return result;
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


static void _g_object_unref0_ (gpointer var) {
	(var == NULL) ? NULL : (var = (g_object_unref (var), NULL));
}


static void _g_list_free__g_object_unref0_ (GList* self) {
	g_list_foreach (self, (GFunc) _g_object_unref0_, NULL);
	g_list_free (self);
}


static GList* daemon_data_sqlite_data_real_GetLog (DaemonDataIDataAccess* base, const gchar* channel, const gchar* server, GError** error) {
	DaemonDataSqliteData * self;
	GList* result = NULL;
	gchar* _tmp0_;
	gchar* commandText;
	sqlite3_stmt* statement = NULL;
	sqlite3_stmt* _tmp1_ = NULL;
	gchar* _tmp2_;
	gchar* _tmp3_;
	gint _result_;
	GList* results;
	GError * _inner_error_ = NULL;
	self = (DaemonDataSqliteData*) base;
	g_return_val_if_fail (channel != NULL, NULL);
	g_return_val_if_fail (server != NULL, NULL);
	_tmp0_ = g_strdup ("SELECT * FROM Log WHERE Channel = @1 AND Server = @2 ORDER BY Timestam" \
"p DESC LIMIT 50");
	commandText = _tmp0_;
	sqlite3_prepare_v2 (self->priv->_database, commandText, -1, &_tmp1_, NULL);
	_sqlite3_finalize0 (statement);
	statement = _tmp1_;
	_tmp2_ = g_strdup (channel);
	sqlite3_bind_text (statement, 1, _tmp2_, -1, g_free);
	_tmp3_ = g_strdup (server);
	sqlite3_bind_text (statement, 2, _tmp3_, -1, g_free);
	_result_ = 0;
	results = NULL;
	{
		gboolean _tmp4_;
		_tmp4_ = TRUE;
		while (TRUE) {
			gint _tmp5_;
			if (!_tmp4_) {
				if (!(_result_ == SQLITE_ROW)) {
					break;
				}
			}
			_tmp4_ = FALSE;
			_tmp5_ = sqlite3_step (statement);
			_result_ = _tmp5_;
			switch (_result_) {
				case SQLITE_DONE:
				{
					{
						break;
					}
				}
				case SQLITE_ROW:
				{
					{
						const gchar* _tmp6_ = NULL;
						gchar* _tmp7_;
						gchar* username;
						const gchar* _tmp8_ = NULL;
						gchar* _tmp9_;
						gchar* data;
						const gchar* _tmp10_ = NULL;
						gchar* _tmp11_;
						gchar* eventChannel;
						const gchar* _tmp12_ = NULL;
						gchar* _tmp13_;
						gchar* eventServer;
						gint64 _tmp14_;
						GDateTime* _tmp15_ = NULL;
						GDateTime* timestamp;
						gint _tmp16_;
						DaemonDataEventTypes type;
						DaemonEventsLogEvent* current;
						DaemonEventsLogEvent* _tmp21_;
						_tmp6_ = sqlite3_column_text (statement, 0);
						_tmp7_ = g_strdup (_tmp6_);
						username = _tmp7_;
						_tmp8_ = sqlite3_column_text (statement, 1);
						_tmp9_ = g_strdup (_tmp8_);
						data = _tmp9_;
						_tmp10_ = sqlite3_column_text (statement, 2);
						_tmp11_ = g_strdup (_tmp10_);
						eventChannel = _tmp11_;
						_tmp12_ = sqlite3_column_text (statement, 3);
						_tmp13_ = g_strdup (_tmp12_);
						eventServer = _tmp13_;
						_tmp14_ = sqlite3_column_int64 (statement, 4);
						_tmp15_ = daemon_helpers_date_time_converter_FromUnixTimestamp (_tmp14_);
						timestamp = _tmp15_;
						_tmp16_ = sqlite3_column_int (statement, 5);
						type = (DaemonDataEventTypes) _tmp16_;
						current = NULL;
						switch (type) {
							case DAEMON_DATA_EVENT_TYPES_Joined:
							{
								{
									DaemonEventsStatusEvent* _tmp17_ = NULL;
									_tmp17_ = daemon_events_status_event_new_WithTimestamp (username, DAEMON_EVENTS_STATUS_CHANGE_Join, eventChannel, eventServer, timestamp);
									_g_object_unref0 (current);
									current = (DaemonEventsLogEvent*) _tmp17_;
									break;
								}
							}
							case DAEMON_DATA_EVENT_TYPES_Left:
							{
								{
									DaemonEventsStatusEvent* _tmp18_ = NULL;
									_tmp18_ = daemon_events_status_event_new_WithTimestamp (username, DAEMON_EVENTS_STATUS_CHANGE_Leave, eventChannel, eventServer, timestamp);
									_g_object_unref0 (current);
									current = (DaemonEventsLogEvent*) _tmp18_;
									break;
								}
							}
							case DAEMON_DATA_EVENT_TYPES_ChangedName:
							{
								{
									DaemonEventsChangeNameEvent* _tmp19_ = NULL;
									_tmp19_ = daemon_events_change_name_event_new_WithTimestamp (username, data, eventChannel, eventServer, timestamp);
									_g_object_unref0 (current);
									current = (DaemonEventsLogEvent*) _tmp19_;
									break;
								}
							}
							case DAEMON_DATA_EVENT_TYPES_Message:
							{
								{
									DaemonEventsMessageEvent* _tmp20_ = NULL;
									_tmp20_ = daemon_events_message_event_new_WithTimestamp (username, data, eventChannel, eventServer, timestamp);
									_g_object_unref0 (current);
									current = (DaemonEventsLogEvent*) _tmp20_;
									break;
								}
							}
							default:
							break;
						}
						_tmp21_ = _g_object_ref0 (current);
						results = g_list_append (results, _tmp21_);
						_g_object_unref0 (current);
						_g_date_time_unref0 (timestamp);
						_g_free0 (eventServer);
						_g_free0 (eventChannel);
						_g_free0 (data);
						_g_free0 (username);
						break;
					}
				}
				default:
				{
					{
						const gchar* _tmp22_ = NULL;
						GError* _tmp23_ = NULL;
						_tmp22_ = sqlite3_errmsg (self->priv->_database);
						_tmp23_ = g_error_new_literal (DAEMON_DATA_DATA_ACCESS_ERROR, DAEMON_DATA_DATA_ACCESS_ERROR_ReadError, _tmp22_);
						_inner_error_ = _tmp23_;
						if (_inner_error_->domain == DAEMON_DATA_DATA_ACCESS_ERROR) {
							g_propagate_error (error, _inner_error_);
							__g_list_free__g_object_unref0_0 (results);
							_sqlite3_finalize0 (statement);
							_g_free0 (commandText);
							return NULL;
						} else {
							__g_list_free__g_object_unref0_0 (results);
							_sqlite3_finalize0 (statement);
							_g_free0 (commandText);
							g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
							g_clear_error (&_inner_error_);
							return NULL;
						}
					}
				}
			}
		}
	}
	result = results;
	_sqlite3_finalize0 (statement);
	_g_free0 (commandText);
	return result;
}


DaemonDataSqliteData* daemon_data_sqlite_data_construct (GType object_type) {
	DaemonDataSqliteData * self = NULL;
	self = (DaemonDataSqliteData*) g_object_new (object_type, NULL);
	return self;
}


DaemonDataSqliteData* daemon_data_sqlite_data_new (void) {
	return daemon_data_sqlite_data_construct (DAEMON_DATA_TYPE_SQLITE_DATA);
}


static void daemon_data_sqlite_data_class_init (DaemonDataSqliteDataClass * klass) {
	daemon_data_sqlite_data_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (DaemonDataSqliteDataPrivate));
	G_OBJECT_CLASS (klass)->finalize = daemon_data_sqlite_data_finalize;
}


static void daemon_data_sqlite_data_daemon_data_idata_access_interface_init (DaemonDataIDataAccessIface * iface) {
	daemon_data_sqlite_data_daemon_data_idata_access_parent_iface = g_type_interface_peek_parent (iface);
	iface->Init = (void (*)(DaemonDataIDataAccess* ,const gchar* ,GError**)) daemon_data_sqlite_data_real_Init;
	iface->Log = (void (*)(DaemonDataIDataAccess* ,DaemonEventsLogEvent* ,GError**)) daemon_data_sqlite_data_real_Log;
	iface->UserLastSeen = (GDateTime* (*)(DaemonDataIDataAccess* ,const gchar* ,const gchar* ,const gchar* ,GError**)) daemon_data_sqlite_data_real_UserLastSeen;
	iface->GetLog = (GList* (*)(DaemonDataIDataAccess* ,const gchar* ,const gchar* ,GError**)) daemon_data_sqlite_data_real_GetLog;
}


static void daemon_data_sqlite_data_instance_init (DaemonDataSqliteData * self) {
	self->priv = DAEMON_DATA_SQLITE_DATA_GET_PRIVATE (self);
}


static void daemon_data_sqlite_data_finalize (GObject* obj) {
	DaemonDataSqliteData * self;
	self = DAEMON_DATA_SQLITE_DATA (obj);
	_sqlite3_close0 (self->priv->_database);
	G_OBJECT_CLASS (daemon_data_sqlite_data_parent_class)->finalize (obj);
}


GType daemon_data_sqlite_data_get_type (void) {
	static volatile gsize daemon_data_sqlite_data_type_id__volatile = 0;
	if (g_once_init_enter (&daemon_data_sqlite_data_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (DaemonDataSqliteDataClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) daemon_data_sqlite_data_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (DaemonDataSqliteData), 0, (GInstanceInitFunc) daemon_data_sqlite_data_instance_init, NULL };
		static const GInterfaceInfo daemon_data_idata_access_info = { (GInterfaceInitFunc) daemon_data_sqlite_data_daemon_data_idata_access_interface_init, (GInterfaceFinalizeFunc) NULL, NULL};
		GType daemon_data_sqlite_data_type_id;
		daemon_data_sqlite_data_type_id = g_type_register_static (G_TYPE_OBJECT, "DaemonDataSqliteData", &g_define_type_info, 0);
		g_type_add_interface_static (daemon_data_sqlite_data_type_id, DAEMON_DATA_TYPE_IDATA_ACCESS, &daemon_data_idata_access_info);
		g_once_init_leave (&daemon_data_sqlite_data_type_id__volatile, daemon_data_sqlite_data_type_id);
	}
	return daemon_data_sqlite_data_type_id__volatile;
}


