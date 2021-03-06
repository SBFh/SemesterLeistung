/* Entity.c generated by valac 0.12.0, the Vala compiler
 * generated from Entity.vala, do not modify */

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


#define DAEMON_IRC_TYPE_ENTITY (daemon_irc_entity_get_type ())
#define DAEMON_IRC_ENTITY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), DAEMON_IRC_TYPE_ENTITY, DaemonIRCEntity))
#define DAEMON_IRC_ENTITY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), DAEMON_IRC_TYPE_ENTITY, DaemonIRCEntityClass))
#define DAEMON_IRC_IS_ENTITY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), DAEMON_IRC_TYPE_ENTITY))
#define DAEMON_IRC_IS_ENTITY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), DAEMON_IRC_TYPE_ENTITY))
#define DAEMON_IRC_ENTITY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), DAEMON_IRC_TYPE_ENTITY, DaemonIRCEntityClass))

typedef struct _DaemonIRCEntity DaemonIRCEntity;
typedef struct _DaemonIRCEntityClass DaemonIRCEntityClass;
typedef struct _DaemonIRCEntityPrivate DaemonIRCEntityPrivate;
#define _g_free0(var) (var = (g_free (var), NULL))
#define _g_string_free0(var) ((var == NULL) ? NULL : (var = (g_string_free (var, TRUE), NULL)))

typedef enum  {
	DAEMON_IRC_ENTITY_ERROR_InvalidFormat
} DaemonIRCEntityError;
#define DAEMON_IRC_ENTITY_ERROR daemon_irc_entity_error_quark ()
struct _DaemonIRCEntity {
	GObject parent_instance;
	DaemonIRCEntityPrivate * priv;
};

struct _DaemonIRCEntityClass {
	GObjectClass parent_class;
};

struct _DaemonIRCEntityPrivate {
	gchar* _Name;
	gchar* _RealName;
	gchar* _Host;
};


static gpointer daemon_irc_entity_parent_class = NULL;

GQuark daemon_irc_entity_error_quark (void);
GType daemon_irc_entity_get_type (void) G_GNUC_CONST;
#define DAEMON_IRC_ENTITY_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), DAEMON_IRC_TYPE_ENTITY, DaemonIRCEntityPrivate))
enum  {
	DAEMON_IRC_ENTITY_DUMMY_PROPERTY,
	DAEMON_IRC_ENTITY_NAME,
	DAEMON_IRC_ENTITY_REAL_NAME,
	DAEMON_IRC_ENTITY_HOST
};
static DaemonIRCEntity* daemon_irc_entity_new (const gchar* name, const gchar* realName, const gchar* host);
static DaemonIRCEntity* daemon_irc_entity_construct (GType object_type, const gchar* name, const gchar* realName, const gchar* host);
static void daemon_irc_entity_set_Name (DaemonIRCEntity* self, const gchar* value);
static void daemon_irc_entity_set_RealName (DaemonIRCEntity* self, const gchar* value);
static void daemon_irc_entity_set_Host (DaemonIRCEntity* self, const gchar* value);
gchar* daemon_irc_entity_ToString (DaemonIRCEntity* self);
const gchar* daemon_irc_entity_get_Name (DaemonIRCEntity* self);
const gchar* daemon_irc_entity_get_RealName (DaemonIRCEntity* self);
const gchar* daemon_irc_entity_get_Host (DaemonIRCEntity* self);
DaemonIRCEntity* daemon_irc_entity_Parse (const gchar* text, GError** error);
static void daemon_irc_entity_finalize (GObject* obj);
static void _vala_daemon_irc_entity_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void _vala_daemon_irc_entity_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);
static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func);
static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func);
static gint _vala_array_length (gpointer array);


GQuark daemon_irc_entity_error_quark (void) {
	return g_quark_from_static_string ("daemon_irc_entity_error-quark");
}


static DaemonIRCEntity* daemon_irc_entity_construct (GType object_type, const gchar* name, const gchar* realName, const gchar* host) {
	DaemonIRCEntity * self = NULL;
	g_return_val_if_fail (name != NULL, NULL);
	self = (DaemonIRCEntity*) g_object_new (object_type, NULL);
	daemon_irc_entity_set_Name (self, name);
	daemon_irc_entity_set_RealName (self, realName);
	daemon_irc_entity_set_Host (self, host);
	return self;
}


static DaemonIRCEntity* daemon_irc_entity_new (const gchar* name, const gchar* realName, const gchar* host) {
	return daemon_irc_entity_construct (DAEMON_IRC_TYPE_ENTITY, name, realName, host);
}


gchar* daemon_irc_entity_ToString (DaemonIRCEntity* self) {
	gchar* result = NULL;
	GString* _tmp0_ = NULL;
	GString* builder;
	gchar* _tmp1_;
	g_return_val_if_fail (self != NULL, NULL);
	_tmp0_ = g_string_new ("");
	builder = _tmp0_;
	g_string_append (builder, "{ Name: ");
	g_string_append (builder, self->priv->_Name);
	if (self->priv->_RealName != NULL) {
		g_string_append (builder, ", Real Name: ");
		g_string_append (builder, self->priv->_RealName);
	}
	if (self->priv->_Host != NULL) {
		g_string_append (builder, ", Host: ");
		g_string_append (builder, self->priv->_Host);
	}
	g_string_append (builder, " }");
	_tmp1_ = g_strdup (builder->str);
	result = _tmp1_;
	_g_string_free0 (builder);
	return result;
}


static gchar* string_strip (const gchar* self) {
	gchar* result = NULL;
	gchar* _tmp0_ = NULL;
	gchar* _result_;
	g_return_val_if_fail (self != NULL, NULL);
	_tmp0_ = g_strdup (self);
	_result_ = _tmp0_;
	g_strstrip (_result_);
	result = _result_;
	return result;
}


static gboolean string_contains (const gchar* self, const gchar* needle) {
	gboolean result = FALSE;
	gchar* _tmp0_ = NULL;
	g_return_val_if_fail (self != NULL, FALSE);
	g_return_val_if_fail (needle != NULL, FALSE);
	_tmp0_ = strstr ((gchar*) self, (gchar*) needle);
	result = _tmp0_ != NULL;
	return result;
}


static gchar string_get (const gchar* self, glong index) {
	gchar result = '\0';
	g_return_val_if_fail (self != NULL, '\0');
	result = ((gchar*) self)[index];
	return result;
}


static glong string_strnlen (gchar* str, glong maxlen) {
	glong result = 0L;
	gchar* _tmp0_ = NULL;
	gchar* end;
	_tmp0_ = memchr (str, 0, (gsize) maxlen);
	end = _tmp0_;
	if (end == NULL) {
		result = maxlen;
		return result;
	} else {
		result = (glong) (end - str);
		return result;
	}
}


static gchar* string_substring (const gchar* self, glong offset, glong len) {
	gchar* result = NULL;
	glong string_length = 0L;
	gboolean _tmp0_ = FALSE;
	gchar* _tmp3_ = NULL;
	g_return_val_if_fail (self != NULL, NULL);
	if (offset >= 0) {
		_tmp0_ = len >= 0;
	} else {
		_tmp0_ = FALSE;
	}
	if (_tmp0_) {
		glong _tmp1_;
		_tmp1_ = string_strnlen ((gchar*) self, offset + len);
		string_length = _tmp1_;
	} else {
		gint _tmp2_;
		_tmp2_ = strlen (self);
		string_length = (glong) _tmp2_;
	}
	if (offset < 0) {
		offset = string_length + offset;
		g_return_val_if_fail (offset >= 0, NULL);
	} else {
		g_return_val_if_fail (offset <= string_length, NULL);
	}
	if (len < 0) {
		len = string_length - offset;
	}
	g_return_val_if_fail ((offset + len) <= string_length, NULL);
	_tmp3_ = g_strndup (((gchar*) self) + offset, (gsize) len);
	result = _tmp3_;
	return result;
}


DaemonIRCEntity* daemon_irc_entity_Parse (const gchar* text, GError** error) {
	DaemonIRCEntity* result = NULL;
	gchar* _tmp0_ = NULL;
	gchar* input;
	gint _tmp1_;
	gchar* _tmp3_;
	gchar* name;
	gchar* realName;
	gchar* host;
	gboolean _tmp4_;
	DaemonIRCEntity* _tmp18_ = NULL;
	GError * _inner_error_ = NULL;
	g_return_val_if_fail (text != NULL, NULL);
	_tmp0_ = string_strip (text);
	input = _tmp0_;
	_tmp1_ = strlen (input);
	if (_tmp1_ == 0) {
		GError* _tmp2_ = NULL;
		_tmp2_ = g_error_new_literal (DAEMON_IRC_ENTITY_ERROR, DAEMON_IRC_ENTITY_ERROR_InvalidFormat, "User empty");
		_inner_error_ = _tmp2_;
		if (_inner_error_->domain == DAEMON_IRC_ENTITY_ERROR) {
			g_propagate_error (error, _inner_error_);
			_g_free0 (input);
			return NULL;
		} else {
			_g_free0 (input);
			g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return NULL;
		}
	}
	_tmp3_ = g_strdup (input);
	name = _tmp3_;
	realName = NULL;
	host = NULL;
	_tmp4_ = string_contains (input, "!");
	if (_tmp4_) {
		gchar** _tmp5_;
		gchar** _tmp6_ = NULL;
		gchar** nameParts;
		gint nameParts_length1;
		gint _nameParts_size_;
		gchar* _tmp7_ = NULL;
		_tmp6_ = _tmp5_ = g_strsplit (input, "!", 0);
		nameParts = _tmp6_;
		nameParts_length1 = _vala_array_length (_tmp5_);
		_nameParts_size_ = _vala_array_length (_tmp5_);
		_tmp7_ = string_strip (nameParts[0]);
		_g_free0 (name);
		name = _tmp7_;
		if (nameParts_length1 > 1) {
			gchar* _tmp8_;
			gboolean _tmp9_;
			gboolean _tmp14_ = FALSE;
			gint _tmp15_;
			_tmp8_ = g_strdup (nameParts[1]);
			_g_free0 (realName);
			realName = _tmp8_;
			_tmp9_ = string_contains (realName, "@");
			if (_tmp9_) {
				gchar** _tmp10_;
				gchar** _tmp11_ = NULL;
				gchar** hostParts;
				gint hostParts_length1;
				gint _hostParts_size_;
				gchar* _tmp12_ = NULL;
				_tmp11_ = _tmp10_ = g_strsplit (realName, "@", 0);
				hostParts = _tmp11_;
				hostParts_length1 = _vala_array_length (_tmp10_);
				_hostParts_size_ = _vala_array_length (_tmp10_);
				_tmp12_ = string_strip (hostParts[0]);
				_g_free0 (realName);
				realName = _tmp12_;
				if (hostParts_length1 > 1) {
					gchar* _tmp13_ = NULL;
					_tmp13_ = string_strip (hostParts[1]);
					_g_free0 (host);
					host = _tmp13_;
				}
				hostParts = (_vala_array_free (hostParts, hostParts_length1, (GDestroyNotify) g_free), NULL);
			}
			_tmp15_ = strlen (realName);
			if (_tmp15_ > 0) {
				gchar _tmp16_;
				_tmp16_ = string_get (realName, (glong) 0);
				_tmp14_ = _tmp16_ == '~';
			} else {
				_tmp14_ = FALSE;
			}
			if (_tmp14_) {
				gchar* _tmp17_ = NULL;
				_tmp17_ = string_substring (realName, (glong) 1, (glong) (-1));
				_g_free0 (realName);
				realName = _tmp17_;
			}
		}
		nameParts = (_vala_array_free (nameParts, nameParts_length1, (GDestroyNotify) g_free), NULL);
	}
	_tmp18_ = daemon_irc_entity_new (name, realName, host);
	result = _tmp18_;
	_g_free0 (host);
	_g_free0 (realName);
	_g_free0 (name);
	_g_free0 (input);
	return result;
}


const gchar* daemon_irc_entity_get_Name (DaemonIRCEntity* self) {
	const gchar* result;
	g_return_val_if_fail (self != NULL, NULL);
	result = self->priv->_Name;
	return result;
}


static void daemon_irc_entity_set_Name (DaemonIRCEntity* self, const gchar* value) {
	gchar* _tmp0_;
	g_return_if_fail (self != NULL);
	_tmp0_ = g_strdup (value);
	_g_free0 (self->priv->_Name);
	self->priv->_Name = _tmp0_;
	g_object_notify ((GObject *) self, "Name");
}


const gchar* daemon_irc_entity_get_RealName (DaemonIRCEntity* self) {
	const gchar* result;
	g_return_val_if_fail (self != NULL, NULL);
	result = self->priv->_RealName;
	return result;
}


static void daemon_irc_entity_set_RealName (DaemonIRCEntity* self, const gchar* value) {
	gchar* _tmp0_;
	g_return_if_fail (self != NULL);
	_tmp0_ = g_strdup (value);
	_g_free0 (self->priv->_RealName);
	self->priv->_RealName = _tmp0_;
	g_object_notify ((GObject *) self, "RealName");
}


const gchar* daemon_irc_entity_get_Host (DaemonIRCEntity* self) {
	const gchar* result;
	g_return_val_if_fail (self != NULL, NULL);
	result = self->priv->_Host;
	return result;
}


static void daemon_irc_entity_set_Host (DaemonIRCEntity* self, const gchar* value) {
	gchar* _tmp0_;
	g_return_if_fail (self != NULL);
	_tmp0_ = g_strdup (value);
	_g_free0 (self->priv->_Host);
	self->priv->_Host = _tmp0_;
	g_object_notify ((GObject *) self, "Host");
}


static void daemon_irc_entity_class_init (DaemonIRCEntityClass * klass) {
	daemon_irc_entity_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (DaemonIRCEntityPrivate));
	G_OBJECT_CLASS (klass)->get_property = _vala_daemon_irc_entity_get_property;
	G_OBJECT_CLASS (klass)->set_property = _vala_daemon_irc_entity_set_property;
	G_OBJECT_CLASS (klass)->finalize = daemon_irc_entity_finalize;
	g_object_class_install_property (G_OBJECT_CLASS (klass), DAEMON_IRC_ENTITY_NAME, g_param_spec_string ("Name", "Name", "Name", NULL, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE));
	g_object_class_install_property (G_OBJECT_CLASS (klass), DAEMON_IRC_ENTITY_REAL_NAME, g_param_spec_string ("RealName", "RealName", "RealName", NULL, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE));
	g_object_class_install_property (G_OBJECT_CLASS (klass), DAEMON_IRC_ENTITY_HOST, g_param_spec_string ("Host", "Host", "Host", NULL, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE));
}


static void daemon_irc_entity_instance_init (DaemonIRCEntity * self) {
	self->priv = DAEMON_IRC_ENTITY_GET_PRIVATE (self);
}


static void daemon_irc_entity_finalize (GObject* obj) {
	DaemonIRCEntity * self;
	self = DAEMON_IRC_ENTITY (obj);
	_g_free0 (self->priv->_Name);
	_g_free0 (self->priv->_RealName);
	_g_free0 (self->priv->_Host);
	G_OBJECT_CLASS (daemon_irc_entity_parent_class)->finalize (obj);
}


GType daemon_irc_entity_get_type (void) {
	static volatile gsize daemon_irc_entity_type_id__volatile = 0;
	if (g_once_init_enter (&daemon_irc_entity_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (DaemonIRCEntityClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) daemon_irc_entity_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (DaemonIRCEntity), 0, (GInstanceInitFunc) daemon_irc_entity_instance_init, NULL };
		GType daemon_irc_entity_type_id;
		daemon_irc_entity_type_id = g_type_register_static (G_TYPE_OBJECT, "DaemonIRCEntity", &g_define_type_info, 0);
		g_once_init_leave (&daemon_irc_entity_type_id__volatile, daemon_irc_entity_type_id);
	}
	return daemon_irc_entity_type_id__volatile;
}


static void _vala_daemon_irc_entity_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	DaemonIRCEntity * self;
	self = DAEMON_IRC_ENTITY (object);
	switch (property_id) {
		case DAEMON_IRC_ENTITY_NAME:
		g_value_set_string (value, daemon_irc_entity_get_Name (self));
		break;
		case DAEMON_IRC_ENTITY_REAL_NAME:
		g_value_set_string (value, daemon_irc_entity_get_RealName (self));
		break;
		case DAEMON_IRC_ENTITY_HOST:
		g_value_set_string (value, daemon_irc_entity_get_Host (self));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void _vala_daemon_irc_entity_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	DaemonIRCEntity * self;
	self = DAEMON_IRC_ENTITY (object);
	switch (property_id) {
		case DAEMON_IRC_ENTITY_NAME:
		daemon_irc_entity_set_Name (self, g_value_get_string (value));
		break;
		case DAEMON_IRC_ENTITY_REAL_NAME:
		daemon_irc_entity_set_RealName (self, g_value_get_string (value));
		break;
		case DAEMON_IRC_ENTITY_HOST:
		daemon_irc_entity_set_Host (self, g_value_get_string (value));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	if ((array != NULL) && (destroy_func != NULL)) {
		int i;
		for (i = 0; i < array_length; i = i + 1) {
			if (((gpointer*) array)[i] != NULL) {
				destroy_func (((gpointer*) array)[i]);
			}
		}
	}
}


static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	_vala_array_destroy (array, array_length, destroy_func);
	g_free (array);
}


static gint _vala_array_length (gpointer array) {
	int length;
	length = 0;
	if (array) {
		while (((gpointer*) array)[length]) {
			length++;
		}
	}
	return length;
}



