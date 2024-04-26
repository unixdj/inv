AILCONF	?= conf.t
AILPATH	?= .:inc:../inc:${HOME}/.ail
MACROS	= -M${AILPATH} -ms -mail
PRINTER	= ps
PAPER	= -P-pa4 -dpaper=a4
ROFF	= groff -T${PRINTER} -m${PRINTER} ${PAPER} ${MACROS} ${PAGES}
NROFF	= nroff -c -Tutf8 ${MACROS} ${PAGES}
SOELIM	= soelim
SOFLAGS	= -I ${AILPATH}
SRCS	:= $(shell echo *.ms)
PSS	= ${SRCS:.ms=.ps}
PDFS	= ${SRCS:.ms=.pdf}
TXTS	= ${SRCS:.ms=.txt}

all: ${PDFS}

.SUFFIXES: .pdf .ps .txt .ms

.PHONY: all clean

.DELETE_ON_ERROR: *

.ms.ps:
	${SOELIM} ${SOFLAGS} ${AILCONF} $< | ${ROFF} >$@

.ms.txt:
	${SOELIM} ${SOFLAGS} ${AILCONF} $< | ${NROFF} >$@

.ps.pdf:
	ps2pdf $<

#clean:
#	-rm -rf ${PSS} ${PDFS} ${TXTS}
