NULL = 

AM_CPPFLAGS = \
	$(SEMESTERLEISTUNG_CFLAGS) \
	-include $(CONFIG_HEADER) \
	$(NULL)

bin_PROGRAMS = SemesterLeistung

SemesterLeistung_SOURCES = \
	main.vala \
	PluginRegistrar.vala \
	PluginManager.vala \
	IRC/IRCConnection.vala \
	Data/IDataAccess.vala \
	Data/SqliteData.vala \
	Helpers/DateTimeConverter.vala \
	Events/Event.vala \
	Events/StatusEvent.vala \
	Events/ChangeNameEvent.vala \
	Events/MessageEvent.vala \
	$(NULL)

SemesterLeistung_LDADD = \
	$(SEMESTERLEISTUNG_LIBS) \
	$(NULL)
	
SemesterLeistung_LDFLAGS = \
	-lsqlite3 \
	-lgio-2.0 \
	-lgmodule-2.0 \
	$(NULL)
	
SemesterLeistung_VALAFLAGS= \
	--pkg gio-2.0 \
	--pkg sqlite3 \
	--pkg gmodule-2.0 \
	--thread \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)

