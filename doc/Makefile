INVDIR	?= ../inc
INV	= ${INVDIR}/inv
TMAC	= ${INVDIR}/tmac.inv
MACROS	= -M${INVDIR} -ms -minv
PRINTER	= ps
PAPER	= -P-pa4
ROFF	= groff -T${PRINTER} -m${PRINTER} ${PAPER} ${MACROS} ${PAGES}
NROFF	= nroff -c -Tutf8 ${MACROS} ${PAGES}
SOELIM	= soelim
SOFLAGS	= -I .:inc:${INVDIR}
SRCS	= manual.ms
PSS	= ${SRCS:.ms=.ps}
PDFS	= ${SRCS:.ms=.pdf}
TXTS	= ${SRCS:.ms=.txt}
TARGS	= ${PSS} ${PDFS}
2SRCS	= conf.2 invoice.2 nitama-letter.2
VTARG	= vars
ITARGS	= ${2SRCS:.2=.p} ${2SRCS:.2=.t} ${VTARG}
INCS	= ${ITARGS}

all: ${TARGS}

.SUFFIXES: .pdf .ps .txt .ms .2 .p .t .e

.PHONY: all clean cleandir distclean

.DELETE_ON_ERROR: *

${PSS} ${TXTS}: ${SRCS} ${INCS}

.ms.ps:
	${SOELIM} ${SOFLAGS} $< | pic | ${INV} | tbl | ${ROFF} >$@

.ms.txt:
	${SOELIM} ${SOFLAGS} $< | ${INV} | tbl | ${NROFF} >$@

.ps.pdf:
	ps2pdf $<

.2.t:
	sed -f 2t $< >$@

.2.p:
	sed -f 2p $< >$@

.2.e:
	sed -f 2e $< >$@

${VTARG}: ${TMAC}
	sed -n -e '/^\.ds [/_]/s/\\/\\e/gp' ${TMAC} >${VTARG}

clean:
	-rm -f ${TARGS} ${TXTS} ${ITARGS}

cleandir distclean: clean
