INVDIR	?= ../inc
INVCONF	?= conf.t
INVPATH	?= .:inc:${INVDIR}
INV	= ${INVDIR}/inv
MACROS	= -M${INVDIR} -ms -mail -minv
PRINTER	= ps
PAPER	= -P-pa4 -dpaper=a4
ROFF	= groff -T${PRINTER} -m${PRINTER} ${PAPER} ${MACROS} ${PAGES}
NROFF	= nroff -c -Tutf8 ${MACROS} ${PAGES}
SOELIM	= soelim
SOFLAGS	= -I ${INVPATH}
SRCS	= date-formatting.ms due-date.ms footer.ms letter.ms \
	  multi-tax-invoice.ms ms.ms service-period.ms taxed.ms ${GENSRCS}
GENSRCS	= invoice.ms letter.ms nitama-letter.ms 
PSS	= ${SRCS:.ms=.ps}
PDFS	= ${SRCS:.ms=.pdf}
TXTS	= ${SRCS:.ms=.txt}

all: ${PDFS}

.SUFFIXES: .pdf .ps .txt .ms

.PHONY: all gen clean cleandir distclean

.DELETE_ON_ERROR: *

.ms.ps:
	${SOELIM} ${SOFLAGS} ${INVCONF} $< | ${INV} | tbl | ${ROFF} >$@

.ms.txt:
	${SOELIM} ${SOFLAGS} ${INVCONF} $< | ${INV} | tbl | ${NROFF} >$@

.ps.pdf:
	ps2pdf $<

gen: ${GENSRCS}

${GENSRCS}:
	#${MAKE} -C ../doc gen
	for i in ${GENSRCS} ; do \
		sed -f ../doc/2e ../doc/`echo $$i | sed 's/ms$$/2/'` >$$i ; \
	done
clean:
	-rm -rf ${PSS} ${PDFS} ${TXTS}

cleandir distclean: clean
	-rm -rf ${GENSRCS}
