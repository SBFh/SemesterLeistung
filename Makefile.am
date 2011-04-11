NULL = 

#Build in these directories:

SUBDIRS = \
	src \
	po \
	$(NULL)

SemesterLeistungdocdir = ${prefix}/doc/SemesterLeistung
SemesterLeistungdoc_DATA = \
	ChangeLog \
	README \
	COPYING \
	AUTHORS \
	INSTALL \
	NEWS\
	$(NULL)

EXTRA_DIST = \
	$(SemesterLeistungdoc_DATA) \
	intltool-extract.in \
	intltool-merge.in \
	intltool-update.in\
	$(NULL)

DISTCLEANFILES = \
	intltool-extract \
	intltool-merge \
	intltool-update \
	po/.intltool-merge-cache \
	$(NULL)
	
dist_man_MANS = \
	man/SemesterLeistung.1 \
	$(NULL)

