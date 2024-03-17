.de Cq
.CW "\\$1" "\(rq\\$2" "\\$3\(lq"
..
.Di
.ds jF \\*(yR-\\n(Mo-\\n(Dy (\\*(gF)
.\" === Start example code
.rn Df gF
.ds cF \\*(gF
.ds Df \\*(cF
.de eR
.if \\n(Yr>\\$1:(\\n(Yr==\\$1&(\\n(Mo>\\$2:(\\n(Mo==\\$2&(\\n(Dy>=\\$3)))) \{\
.	ds eN \\$4
.	nr eY \\n(Yr-\\$1+1
.	ds yR \\*(eN \\n(eY
.	if !'\\*(jF'' .ds cF \\\\*(jF\}
..
.rn Sr sR
.de Sr
.sR
.eR 0001 01 01
.ds cF \\\\*(gF
.eR 1989 01 08 Heisei
.eR 2019 05 01 Reiwa
..
.de Cd
.Fd Da
.+m 0 -50
.Dd
..
.\" === End example code
.\" Format the date this was written and give it to -ms to put in the footer.
.Id 2024 03 17
.DA \*(Da
.\" No invoice here, just computation of the "due date" (in the
.\" past) based on today's date and a header without a title.
.Id
.Hd
Now: \*(Da
Before: \*(Du
.Be
.sp 2
.PP
This example implements Japanese dates in Heisei and
perpetual Reiwa eras by redefining
.CW .Sr .
The implementation calls the original
.CW .Sr
and adds several registers and strings:
.RS
.TS
li li li li
li lfC l .
R/S	Name	Within eras	Before Heisei
Register	eY	Era year	Gregorian year
String	eN	Era name	Empty
String	yR	Era name \s-2<SPACE>\s0 year	Gregorian year
.TE
.RE
.PP
Thus,
.Cq \e\e*(yR-\e\en(Mo-\e\en(Dy
.ds Df \\*(yR-\\n(Mo-\\n(Dy
will format today's date as
.Fd dS
.Cq "\*(dS"
and the same day (unless you're rendering it on 29 February)
in 1970 as
.nr Yr 1970
.+m 0
.Fd dS
.Cq "\*(dS" .
.PP
The example uses several configuration strings:
.RS
.TS
lfC lx .
gF	T{
Gregorian format.  The original
.CW Df
is moved here.
T}
jF	T{
Japanese format,
to enable using different formats for dates before and within the eras.
E.g., to list both Japanese and Gregorian dates for the latter.
Initially unset.
T}
cF	T{
Chosen format.
Set by
.CW .Sr
each time it runs:
if the date is within defined eras and
.CW jF
is not empty, to
.Cq \e\e*(jF ,
otherwise to
.CW \e\e*(gF .
T}
Df	T{
Initially set to
.Cq \e\e*(cF .
It is there for compatibility.
T}
.TE
.RE
.PP
The dates at the top of the page were printed with
.CW gF
set to the \s-1ISO\s0 format and
.CW jF
to
.Cq "\e\e*(yR-\e\en(Mo-\e\en(Dy (\e\e*(gF)" .
.LD
.CW
\&.\e" Rename Df to gF, link Df \(-> cF \(-> gF
\&.rn Df gF
\&.ds cF \e\e*(gF
\&.ds Df \e\e*(cF
\&.\e" .eR yyyy mm dd name
\&.\e" If the date in the date registers is at or after yyyy-mm-dd,
\&.\e" set eN, eY and yR accordingly, and link cF \(-> jF if it's not empty.
\&.de eR
\&.if \e\en(Yr>\e\e$1:(\e\en(Yr==\e\e$1&(\e\en(Mo>\e\e$2:\e
(\e\en(Mo==\e\e$2&(\e\en(Dy>=\e\e$3)))) \e{\e
\&.	ds eN \e\e$4
\&.	nr eY \e\en(Yr-\e\e$1+1
\&.	ds yR \e\e*(eN \e\en(eY
\&.	if !'\e\e*(jF'' .ds cF \e\e\e\e*(jF\e}
\&..
\&.\e" Rename Sr to sR
\&.rn Sr sR
\&.\e" .Sr
\&.\e" Call the original Sr.
\&.\e" Set eN, eY and yR to the "Japanese era" with an empty name
\&.\e" starting 0001-01-01.  Reset cF to point to gF.
\&.\e" Then try overwrite the data with Heisei and Reiwa dates.
\&.de Sr
\&.sR
\&.eR 0001 01 01
\&.ds cF \e\e*(gF
\&.eR 1989 01 08 Heisei
\&.eR 2019 05 01 Reiwa
\&..
.DE
