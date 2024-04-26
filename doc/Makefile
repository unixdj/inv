INVDIR	?= ../inc
INVPATH	?= .:inc:${INVDIR}
INV	= ${INVDIR}/inv
TMAC	= ${INVDIR}/tmac.inv
MACROS	= -M${INVDIR} -ms -mail -minv
PRINTER	= ps
PAPER	= -P-pa4 -dpaper=a4
ROFF	= groff -T${PRINTER} -m${PRINTER} ${PAPER} ${MACROS} ${PAGES}
NROFF	= nroff -c -Tutf8 ${MACROS} ${PAGES}
SOELIM	= soelim
SOFLAGS	= -I ${INVPATH}
ISRC	= manual.ms
ASRC	= using-mail.ms
SRCS	= ${ISRC} ${ASRC}
APS	= ${ASRC:.ms=.ps}
#IPS	= ${ISRC:.ms=.ps}
PSS	= ${SRCS:.ms=.ps}
PDFS	= ${SRCS:.ms=.pdf}
ATXT	= ${ASRC:.ms=.txt}
TXTS	= ${ISRC:.ms=.txt}
TARGS	= ${PSS} ${PDFS}
I2SRCS	= conf.2 invoice.2 nitama-letter.2
M2SRCS	= letter.2
VTARG	= vars
ITARGS	= ${I2SRCS:.2=.p} ${I2SRCS:.2=.t} ${VTARG}
INCS	= ${ITARGS}
ATARGS	= ${M2SRCS:.2=.p} ${M2SRCS:.2=.t}
AINCS	= ${ATARGS} macs
ICLEAN	= index/foo1 index/foo2 index/foo3 index/foo4 index/foo5 index/foo6
ICLEAN	+= index/foo7 index/foo8 index/foo9
ICLEAN	+= index/junk.all index/junk.regular index/junk.see

all: ${TARGS}

.SUFFIXES: .pdf .ps .txt .ms .2 .p .t .e .ii .idx

.PHONY: all clean cleandir distclean

.DELETE_ON_ERROR: *

manual.ps manual.txt: ${INCS}
using-mail.ps using-mail.txt: ${AINCS}

${APS}: ${APS}.ii
${ATXT}: ${ATXT}.ii
#using-mail.ps: mail-idx.ps.ii
#using-mail.txt: mail-idx.txt.ii

${APS}.idx: ${ASRC} ${AINCS}
	${SOELIM} ${SOFLAGS} using-mail.ms | ${INV} | pic | tbl | eqn | ${ROFF} -dIx=1 >/dev/null 2>$@

${ATXT}.idx: ${ASRC} ${AINCS}
	${SOELIM} ${SOFLAGS} using-mail.ms | ${INV} | pic | tbl | eqn -Tutf8 | ${NROFF} -dIx=1 >/dev/null 2>$@

.idx.ii:
	cd index && ./make.index ../$< >../$@

.ms.ps:
	${SOELIM} ${SOFLAGS} $< | ${INV} | pic | tbl | eqn | ${ROFF} >$@

.ms.txt:
	# ${SOELIM} ${SOFLAGS} $< | ${INV} | tbl | ${NROFF} >$@
	${SOELIM} ${SOFLAGS} $< | ${INV} | pic | tbl | eqn -Tutf8 | ${NROFF} >$@

.ps.pdf:
	ps2pdf $<

.2.t:
	sed -f 2t $< >$@

.2.p:
	sed -f 2p $< >$@

.2.e:
	sed -f 2e $< >$@

${VTARG}: ${TMAC}
	sed -n -e 's/\\"$$//' -e '/^\.ds [/_]/s/\\/\\e/gp' ${TMAC} >${VTARG}

clean:
	-rm -f ${TARGS} ${TXTS} ${ITARGS} ${VTARG} ${ATARGS} \
		${APS}.idx ${ATXT}.idx ${APS}.ii ${ATXT}.ii ${ICLEAN}

cleandir distclean: clean
