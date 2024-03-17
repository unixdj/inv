INVDIR	?= ../inc
INVCONF	?= conf.t
INVPATH	?= .:inc:${INVDIR}
INV	= ${INVDIR}/inv
MACROS	= -M${INVDIR} -ms -minv
PRINTER	= ps
PAPER	= -P-pa4
ROFF	= groff -T${PRINTER} -m${PRINTER} ${PAPER} ${MACROS} ${PAGES}
NROFF	= nroff -c -Tutf8 ${MACROS} ${PAGES}
SOELIM	= soelim
SOFLAGS	= -I ${INVPATH}
SRCS	:= $(shell echo *.ms)
PSS	= ${SRCS:.ms=.ps}
PDFS	= ${SRCS:.ms=.pdf}
TXTS	= ${SRCS:.ms=.txt}

all: ${PDFS}

.SUFFIXES: .pdf .ps .txt .ms

.PHONY: all clean

.DELETE_ON_ERROR: *

.ms.ps:
	${SOELIM} ${SOFLAGS} ${INVCONF} $< | ${INV} | tbl | ${ROFF} >$@

.ms.txt:
	${SOELIM} ${SOFLAGS} ${INVCONF} $< | ${INV} | tbl | ${NROFF} >$@

.ps.pdf:
	ps2pdf $<

#clean:
#	-rm -rf ${PSS} ${PDFS} ${TXTS}
