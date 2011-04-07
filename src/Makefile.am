NULL = 

AM_CPPFLAGS = \
	$(SEMESTERLEISTUNG_CFLAGS) \
	-include $(CONFIG_HEADER) \
	`xml2-config --cflags` \
	$(NULL)

bin_PROGRAMS = SemesterLeistung

SemesterLeistung_SOURCES = \
	main.vala \
	GlobalLog.vala \
	ConnectionHub.vala \
	PluginRegistrar.vala \
	PluginManager.vala \
	IRC/IRCConnection.vala \
	IRC/Command.vala \
	Data/IDataAccess.vala \
	Data/SqliteData.vala \
	Helpers/DateTimeConverter.vala \
	Helpers/ListHelper.vala \
	Events/Event.vala \
	Events/StatusEvent.vala \
	Events/ChangeNameEvent.vala \
	Events/MessageEvent.vala \
	Configuration/ServerConfiguration.vala \
	Configuration/ConfigurationFile.vala \
	$(NULL)

SemesterLeistung_LDADD = \
	$(SEMESTERLEISTUNG_LIBS) \
	$(NULL)
	
SemesterLeistung_LDFLAGS = \
	-lsqlite3 \
	-lgio-2.0 \
	-lgmodule-2.0 \
	`xml2-config --libs` \
	$(NULL)
	
SemesterLeistung_VALAFLAGS= \
	--pkg gio-2.0 \
	--pkg sqlite3 \
	--pkg gmodule-2.0 \
	--pkg libxml-2.0 \
	--thread \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)

