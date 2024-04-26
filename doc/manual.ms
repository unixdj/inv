.\" Copyright (c) 2024 Vadim Vygonets <vadik@vygo.net>
.de Li
Copyright \(co 2024 Vadim Vygonets
.CW <vadik@vygo.net>
.PP
Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.
.PP
.ps -1
.vs -1
.if t .hy 1
THE SOFTWARE IS PROVIDED
.Qu "AS IS"
AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
..
.\" =============================================================
.Id 2024 4 26
.nr ;x \n(Dy
.DA \n(;x \*(Ml \n(Yr
.nr HY 0
.ds Va \s-1VAT\s0
.ds Eu \s-1EUR\s0
.ds Is \s-1ISO\s0
.ds An \s-1IBAN\s0
.ds Bc \s-1BIC\s0
.ie t \{\
.ds Mi \h'1p'\z\D'l 10p 0'\D'l 0 -6p'\z\D'l 5p 3p'\
\D'l 10p 0'\z\D'l -5p 3p'\D'l 0 6p'\h'1p'
.ds Me \k(;x\h'-\\n(.iu-\\n(.ku-18p'\*(Mi\h'|\\n(;xu'
.ds Mp \k(;x\h'-\\n(.iu-\\n(.ku-\\n(PIu-18p'\*(Mi\h'|\\n(;xu'
.\}
.el \{\
.ds Mi (M)
.ds Me \k(;x\h'\\n(.lu-\\n(.iu-\\n(.ku+6n'\*(Mi\h'|\\n(;xu'
.ds Mp \k(;x\h'\\n(.lu-\\n(.iu-\\n(.ku-\\n(PIu+6n'\*(Mi\h'|\\n(;xu'
.\}
.ds aq '
.if \n(.g .ds aq \(aq
.de Sc
\\$3\s-1\\$1\s0\\$2
..
.de Qu
\\$3\(lq\\$1\(rq\\$2
..
.de Cq
.CW "\\$1" "\(rq\\$2" "\\$3\(lq"
..
.de Cb
\\$3\f(CB\\$1\fP\\$2
..
.de Ic
\\$5\fC\\$3\fP\f(CI\\$1\fP\fC\\$2\fP\\$4
..
.de Ma
.IP "\f(CB\\$1 \fI\\$2"
\v'-1'\\$3\v'1'\c
..
.de Lh
.SH
.ps +1
.vs +1
..
.\" .LP
.TL
Invoice Generator Manual
.\" .sp -1
.AU
Vadim Vygonets
.\" .SH
.\" Introduction
.AB no
.\" .PP
The invoice generator is a document preprocessor
and a troff macro package for invoices.
The
.Cb inv
.\" preprocessor turns a simple invoice description into
preprocessor turns a list of billed items into
.CW tbl
source.
The
.Cb \-minv
macro package provides facilities for invoice headers and footers
and date manipulation in letters written using
.\" adds invoice header and footer to a letter written using
.CW \-ms
and
.CW \-mail
macros.
.\" macro package, built on top of
.\" .CW \-ms
.\" and
.\" .CW \-mail
.\" macros, formats the first page of a letter,
.\" optionally including invoice-related information.
.PP
It was made for freelancers in Germany,
but should be flexible enough to be useful for others.
It started as a simple framework
but grew to have features that nobody needs.
Fortunately, in the process it became more robust and generic,
and remained easy to use.
.AE
.SH
Quick start
.PP
Create the configuration file
.CW inc/conf.t
containing your details, from the template in
.CW inc/conf\-example.t .
.sp -\n(PDu
.ds Xg \fR\h'-\w'\(dg'u/2u-2n'\(dg\fP\h'|0u'
.ds Xd \fR\k(;x\h'-\w'\(dd'u/2u-2n'\(dd\fP\h'|\n(;xu'
.ds Xs \fR\k(;x\h'-\w'\(**'u/2u-2n'\(**\fP\h'|\n(;xu'
.ds Xo \fR\k(;x\h'-\w'\s-2\(es\s0'u/2u-2n'\s-2\(es\s0\fP\h'|\n(;xu'
.so conf.p
.DS
.TS
;
lfC lix .
\*(Xg\&.ds Nm \*(Nm	Name
\*(Xg\&.ds 1a \*(1a	Address line 1
\&.ds 2a \*(2a	Address lines 2\-6
\&.ds 3a \*(3a	\^
\&.ds Ib \*(Ib	\*(An
\&.ds Ba \*(Ba	Bank name
\&.ds Bi \*(Bi	\*(Bc
\*(Xs\&.ds Bl \*(Bl	Bankleitzahl
\&.ds Tn \*(Tn	Tax number
\&.ds Ta \*(Ta	Tax authority
\*(Xd\&.ds Cu \*(Cu	Default currency
\*(Xo\&.nr Cf 0	T{
.fi
.ad l
Flags:
1\ =\ compact sender address,
2\ =\ fold lines
T}
\*(Xo\&.Set tax 0	Default tax rate
\*(Xo\&.Set fmt %.2f	Default currency format
.TE
.so conf.t
.DE
.\" .sp -\n(PDu
.sp -0.8
\h'5'\
\(dg  Mandatory\h'3n'\
\(dd  Mandatory for invoices\h'3n'\
\s-2\(es\s0  Default value shown\h'3n'\
\(**  A German thing
.sp \n(PDu
.PP
For more customisation and localisation options see
.I "Footer customisation"
and
.I "Appendix B" ;
for changing page layout and address box appearance see
.CW doc/using\-mail.pdf .
.PP
Decide how you want to organise your invoices and letters
(e.g., by year).
Create a directory at the same level as
.CW inc
that will contain the document.
Copy or link
.CW inc/Makefile
to that directory.
Create a file
.Ic filename .ms
containing source such as:
.\" .sp -\n(PDu
.DS
.CW
.so invoice.p
.DE
.\" .sp -0.8
.sp -\n(PDu
\h'5'\(**  Optional\h'3n'
.sp \n(PDu
.\" .PP
.\" To write a letter, use only the lines marked with a bar
.\" and put the text below.
.PP
Run
.\" .Ic filename .pdf "make\ "
.CW make
to generate the document.
The source above will result in the invoice on the next page.
.so invoice.t
.Tl
Basic usage
.Te
.PP
An invoice source contains troff code and
.CW inv
commands
.CW .Set ,
.CW .Tax ,
.CW .Taxed ,
.CW .Charge
and
.CW .End ,
starting at the beginning of the line,
with arguments separated by whitespace.
.PP
The file
.CW $INVCONF
(default:
.CW conf.t )
is implicitly included in the beginning.
The location of
.CW inv
and macros is
.CW $INVDIR
(default:
.CW ../inc ),
the search path for included files is
.CW $INVPATH
(default:
.CW .:inc:$INVDIR ).
.PP
The source of a typical invoice is organised as follows:
.DS
.I
overriding default configuration values
\fC.In \fInumber date [due-date]
\fC.Ad "\fIclient name\fC"\fI
client address...
.CW .Ae
invoice table
other troff source
.DE
.sp -\n(PDu
.PP
.\" .PP
Most features are independent from each other,
but many assume that the address block is present.
.\" .CW .In
.\" and the invoice table can be omitted
.\" to generate only the address block when writing a letter.
.PP
.Cb .In
does page setup,
prints the footer and starts the invoice header block
containing the invoice number, date and optional due date.
.\" and sets up the break for the first page above the footer.
.\" If no date is given, it defaults to today.
See
.I "Using numeric dates"
on setting the due date programmatically.
Lines that follow will be added to the block.
No output is allowed before
.CW .In .
.PP
\*(Mp\c
.Cb .Ad
ends an active block and starts the address definition.
.\" Lines that follow will be added to the address.
.\" .PP
.Cb .Ae
ends the definition,
prints the address where it's visible through an
.\" .Sc DL ,
.\" .Sc "C5/C6 (DL+)"
.\" or
.\" .Sc C4
envelope window
and sets the position below the window.
.\" For compatibility with
.\" .CW .AM
.\" from Berkeley and
.\" .Sc GNU
.\" .CW \-ms ,
.\" .CW .Be
.\" can be used instead of
.\" .CW .Ae .
Macros and sections marked with \*(Mi are from
.CW \-mail
and are described in more detail in
.CW doc/using\-mail.pdf .
.PP
You might want to have a file per client
containing the address block and settings
(e.g., zero tax for foreign clients),
and include it with
.Ic client .t ".so\ " .
.\" You might want to put the address block and settings
.\" (e.g., zero tax for foreign clients) for each client
.\" in a separate file and include it with
.\" .Ic client .ms ".so\ " .
.\" Client address and relevant settings
.\" can be included from another file with a troff request such as
.\" .CW ".so\ client.ms" .
.SH
The invoice table
.PP
The first
.CW .Tax
or
.CW .Charge
command starts the invoice table.
.RS
.Ma .Set "var value"
Set
.CW inv
setting
.I var
to
.I value .
The settings are:
.\" default \*(Va rate
.CW tax
(\*(Va rate, default: 0),
.CW fmt
(currency format, default:
.Cq %.2f )
and
.CW warn
(enable warnings, default: 1).
.Ma .Tax \fR[\fPrate\fR]
Set the \*(Va rate for subsequent charges.
.\" An invoice may contain multiple rates.
Charges at each rate are listed separately, with
.Qu Subtotal ,
.Qu "Net\ total" ,
.\" and either
.Qu \*(Va
and
.Qu "Total\ \*(Va"
lines generated as needed.
Without an argument, keep the previous rate;
this form can be used to start the table using the default rate.
.Ma .Charge "price units unit-name description ..."
Generate an invoice entry.
The unit name must be one word.
To suppress it, use
.Cq \e& .
.Cq \e0
can be used instead of
.Sc SPACE .
A description that doesn't fit on one line should be put in a
.CW tbl
block, as shown below.
If used in the first
.CW .Charge
directive, it must be preceded by
.CW .Tax .
.DS
.CW
T{
Line breaks are ignored within tbl blocks.
Use ".bp" on its own line to force a line break.
\&.Charge 100 8 Hours T}
.DE
.Ma .Taxed amount
Set the tax amount for the next
.CW .Charge .
See the section
.I "Setting tax amounts manually" .
.Ma "\f(BIEnd of file\fI, \f(CB.End"
End the invoice table.
Set troff strings
.CW Ne ,
.CW Tx
and
.CW To
to formatted net, tax and total amounts.
.RE
.SH
Writing letters
.PP
A typical letter will start with an
.CW .Ad
/
.CW .Ae
block, followed by text and
.CW \-ms
macros.
.\" which will be printed below the address.
It must have an appropriate
.CW \-minv ,
.CW \-mail
or
.CW \-ms
macro before any text (see the schematic below).
When in doubt, use
.CW .LP .
.PP
.\" Any text before
.\" .CW .Ad
.\" will appear on top of the page.
.\" \*(Mp\c
There are several ways to use the limited space around the address box.
A title, a header block or boxes can be used for additional information.
Or you can just doodle on the margins.
See
.I "Appendix A: Example letter" .
.Tl
Advanced usage
.Te
.\" .\" .BX "You can stop reading now."
.\" .nr ;w \w'\f(BI\|You can stop reading now.\|\fP'
.\" .tl ??Features that nobody needs start here. \
.\" \h'2p'\|\v'0.25'\D'l 0 -1'\D'l \n(;wu 0'\D'l 0 1'\D'l -\n(;wu 0'\
.\" \v'2p'\h'-2p'\D'l 0 -1-4p'\D'l \n(;wu+4p 0'\D'l 0 1+4p'\D'l -\n(;wu-4p 0'\
.\" \v'-0.25-2p'\h'2p'\
.\" \f(BI\|You can stop reading now.\|\fP\h'2p'??
.\" .SM
.\" .sp -\n(PDu
.LP
.ie t \{\
.PS
.\" scale = 2.54
.\" boxwid = 1.8
boxwid = 0.71
movewid = 0.45
linewid = movewid
boxht = 0.39
moveht = boxht
circlerad = boxht / 2
.I
All: [
Start: line "start" above
line up 0.16 invis
arrow from 0.7 <Start.s, Start.e> down 0.5 * moveht \
	then right 2.1 * movewid 2 * boxwid
.CW
In: box ".In"
arrow 0.1 * movewid then up 0.45 * boxht then right 0.9 * movewid
move from In.e
.I
Bx: box "box" "(\f(CI.Bo\fP etc.)" dashed
.CW
arrow from 0.7 <Bx.ne, Bx.se> right 0.3 * movewid \
	then down 0.55 * moveht \
	then left 0.6 * movewid boxwid \
	then to 0.95 <Bx.nw, Bx.sw> - 0.3 * movewid, 0 \
	then to 0.95 <Bx.nw, Bx.sw>
arrow from 0.6 <Start.s, Start.e> down 1.20 * moveht \
	then right 2.4 * movewid 3 * boxwid \
	then to 0.2 <Bx.nw, Bx.sw> - 0.8 * movewid, 0 \
	then to 0.2 <Bx.nw, Bx.sw>
arrow from 0.4 <Start.s, Start.e> down 2 * moveht \
	then right 0.4 * movewid
Ft: box ".Ft" ; arrow ; Id: box ".Id" dashed ; arrow ; Ih: box ".Ih"
arrow 0.3 * movewid \
	then to 0.35 <Bx.nw, Bx.sw> - 0.7 * movewid, 0 \
	then to 0.35 <Bx.nw, Bx.sw>
arrow from Start.c down 1.35 * moveht \
	then right 0.8 * movewid boxwid \
	then to 0.6 <Id.nw, Id.w> + -0.5 * movewid, 0 \
	then to 0.6 <Id.nw, Id.w>
arrow from 0.3 <Start.s, Start.e> down 3.5 * moveht \
	then right boxwid 1.5 * movewid
Tl: box "\s9.Tl safe\s0"
move ; Hd: box ".Hd"
arrow 0.4 * movewid \
	then to 0.5 <Bx.nw, Bx.sw> - 0.6 * movewid, 0 \
	then to 0.5 <Bx.nw, Bx.sw>
arrow from 0.6 <Ft.e, Ft.se> right 0.4 * movewid \
	then to 0.6 <Tl.nw, Tl.w> + -0.6*movewid,0 then to 0.6 <Tl.nw, Tl.w>
arrow from 0.4 <Id.e, Id.se> 0.7 * movewid \
	then to Hd.w + -0.3*movewid,0 then to Hd.w
arrow from 0.3 <Ft.e, Ft.se> right 0.6 * movewid \
	then down 0.75 * moveht - 0.15 * boxht \
	then right boxwid 0.9 * movewid \
	then down 1.35 * moveht \
	then right movewid boxwid \
	then to 0.65 <Bx.nw, Bx.sw> - 0.5 * movewid, 0 \
	then to 0.65 <Bx.nw, Bx.sw>
arrow from Tl.e right 0.3 * movewid \
	then down 0.7 * moveht \
	then right 1.3 * movewid boxwid \
	then to 0.8 <Bx.nw, Bx.sw> - 0.4 * movewid, 0 \
	then to 0.8 <Bx.nw, Bx.sw>
arrow from Bx.e 0.5 * movewid \
	then down 3.9 * moveht \
	then left 4 * movewid 4 * boxwid \
	then down 0.6 * moveht \
	then right 0.5 * movewid
box ".Ad" ; arrow ; box ".Ae"
.I
arrow ; box "invoice" "table" dashed
arrow ; box "any text or\^" "troff \f(CI-ms\fP" dashed
arrow ; circle "end\^"
circle with .c at last circle .c radius circlerad - 0.03
]
.B
"Recommended flow" above "\fRDashed boxes can be skipped through." above \
at All.n
.PE
.\}
.el \{\
.so /dev/null
.DS L
.CW
                          Recommended flow
  start          Plused boxes can be skipped through.
\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru                               \(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru       +++++++++++
  \(br\(br\(br\(br\(br                                \(br         \(br      +   box   +
  \(br\(br\(br\(br\(**\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(->\(br   .In   \(br\(mi\(->\(**\(mi\(mi\(->+  (.Bo   +\(mi\(mi\(**
  \(br\(br\(br\(br                                 \(br         \(br  \(ua   +  etc.)  +\(mi\(**\(br
  \(br\(br\(br\(br                                 \(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br  \(br   +++++++++++ \(br\(br
  \(br\(br\(br\(**\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(->\(**\(<-\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(**\(br
  \(br\(br\(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru                                \(ua                \(br
  \(br\(br   \(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru    \(br  +++++++++++      \(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru   \(br                \(br
  \(br\(br  \(br         \(br   \(da  +         +     \(br         \(br  \(br                \(br
  \(br\(**\(mi\(->\(br   .Ft   \(br\(mi\(mi\(->\(**\(mi\(->+  .Id    +\(mi\(mi\(mi\(mi\(->+   .Ih   +\(mi\(->\(**                \(br
  \(br   \(br         \(br\(ru\(ru\(ru   +         +\(ru\(ru\(ru  \(br         \(br  \(ua                \(br
  \(br   \(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br  \(br\(br  +++++++++++   \(br \(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br  \(br                \(br
  \(br                \(br\(br                \(br              \(br                \(br
  \(br                \(br\(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru  \(br              \(br                \(br
  \(br                \(br    \(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru  \(br \(br  \(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru   \(br                \(br
  \(br                \(da   \(br         \(br \(da \(br \(br         \(br  \(br                \(br
  \(**\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(mi\(->\(**\(mi\(mi\(->\(br .Tl safe\(br\(->\(** \(**\(->\(br   .Hd   \(br\(mi\(->\(**                \(br
                       \(br         \(br \(br   \(br         \(br  \(ua                \(br
                       \(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br \(br   \(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br  \(br                \(br
                                   \(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br                \(br
    \(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br
   \(br   \(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru        \(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru      +++++++++++      +++++++++++
   \(br  \(br         \(br      \(br         \(br     + invoice +      +any text +
   \(**\(mi\(->\(br   .Ad   \(br\(mi\(mi\(mi\(mi\(mi\(->\(br  .Ae    \(br\(mi\(mi\(mi\(mi\(->+  table  +\(mi\(mi\(mi\(mi\(mi\(->+   or    +\(mi\(mi\(mi\(mi\(->end
      \(br         \(br      \(br         \(br     +         +      +troff \-ms+
      \(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br      \(br\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(ru\(br     +++++++++++      +++++++++++
.DE \}
.sp -1
.SH
Header and footer
.PP
Different functions of the
.CW .In
macro can be used separately.
.\" Its full source is:
.\" .DS
.\" .CW
.\" \&.de In
.\" \&.Id \e\e$2 \e\e$3 \e\e$4 \e\e$5 \e\e$6 \e\e$7
.\" \&.Ft
.\" \&.Ih "\e\e$1"
.\" \&..
.\" .DE
.\" .PP
.\" Related macros:
.RS
.sp 3
.sp -3
.Ma .Id "invoice-date \fR[\fPdue-date\fR]"
.sp -\n(PDu-1
.if n .ad l
.Ma .Id "\fR[\fPinvoice-year invoice-month invoice-day \
\fR[\fPdue-year due-month due-day\fR]]"
.if n .ad b
Set the strings
.CW Da
and
.CW Du
to invoice date and due date.
.\" For details about the second form, see the section
.\" .I "Using numeric dates" .
.\" See the section
.\" .I "Using numeric dates"
See the next section
for details.
.Ma .Ft
Set the bottom margin of the page to cover the footer.
If the current page is being printed, eject it.
Print the footer.
Restore bottom margin.
Set the position at the top margin.
.\" No output is allowed before
.\" .CW .Ft .
.Ma .Hd \fR[\fPheader\fR] \\*(Me
Start the header block at the top right.
If
.I header
is given, print it in 16 point bold font.
.Ma .Ih number
Start the invoice header block
.CW .Hd ) (
with the header
.Qu "Invoice \fInumber\fP" .
Print
.Qu Date
and
.Qu "Due date"
fields if the corresponding strings are set.
.sp 3
.sp -3
.Ma .In "number invoice-date \fR[\fPdue-date\fR]"
.sp -\n(PDu-1
.if n .ad l
.Ma .In "number \fR[\fPinvoice-year invoice-month invoice-day \
\fR[\fPdue-year due-month due-day\fR]]"
.if n .ad b
Set dates
.CW .Id ), (
do page setup and print footer
.CW .Ft ), (
start invoice header block
.CW .Ih ). (
.RE
.SH
Using numeric dates
.PP
.CW .In
and
.CW .Id
store the invoice and due dates in troff strings
.Cb Da
and
.Cb Du .
When called with string dates, the strings are set to the arguments.
Otherwise numeric dates are used, as described here.
Numeric dates use registers
.CW Yr ,
.CW Mo
and
.CW Dy .
The earliest supported date is 0001-01-01.
.PP
First, the date registers are set to the invoice date.
If none is given, it defaults to today.
The date is then formatted into
.CW Da .
.PP
Then, if due date is given,
the date registers are set to the due date and it is formatted into
.CW Du .
.\" Otherwise the user-provided macro
Otherwise the
.Cb .Cd
.Qu "calculate date" ) (
macro
is called, if defined by the user.
.\" is called.
It must set
.CW Du
explicitly.
.PP
Finally, the date registers are reset to the invoice date.
.PP
To aid the implementation of
.CW .Cd ,
macros operating on date registers are provided.
.\" Both accept positive or negative arguments.
.\" It is expected that the registers contain a valid date
.\" with a positive year.
.RS
.Ma .+d days
Add
.I days
to the date and normalise date register values.
The argument may be negative.
.Ma .+m "months \fR[\fPyears\fR]"
Add
.I months
and
.I years
to the date.
If the value of
.CW Dy
exceeds the number of days in the resulting month,
set it to the last day of the month.
The arguments may be negative.
.Ma .Dd
Set the due date.
Equivalent to
.Cq ".Fd\ Du" .
.Ma .Sr
Set the registers
.CW Wy ,
.CW Wk
and
.CW Wd
to the \*(Is week date.
Set the strings
.CW Ms ,
.CW Ml ,
.CW Ws
and
.CW Wl
to short month, long month, short week day and long week day.
E.g., for 2024-12-31 the values are
.CW 2025 ,
.CW 01 ,
.CW 2 ,
.Cq Dec ,
.Cq December ,
.Cq Tue
and
.Cq Tuesday .
.Ma .We "year week day"
Set the date to the given \*(Is week date.
.RE
.PP
.I Example:
Add service period
.Qu "\f(CIMonth yyyy\fP" ) (
to the
.CW .Charge
description.
If the invoice day of month is 14 or less,
set it to the previous month, otherwise to the current month.
.DS
.CW
\&.+d -14
\&.Sr
\&.Charge 100 8 Hours Mindless keyboard bashing, \e*(Ml \en(Yr
.DE
.PP
.I Example:
If the invoice date falls on a weekend,
this convoluted implementation of
.CW .Cd
pushes it forward to Monday.
It then sets the due date to
one month after the invoice date,
except on the first or last day of the month,
in which case it's set
to the last day of this or next month, respectively.
.\" If the resulting date falls on a weekend,
.\" it is pushed forward to Monday.
.DS
.CW
\&.de Cd
\&.if \e\en(Wd>5 .+d 8-\e\en(Wd  \e" if Sat or Sun, add 2 or 1 days
\&.Fd Da                     \e" format invoice date
\&.if !\e\en(Dy=1 .+d 1        \e" if day!=1, add a day
\&.if !\e\en(Dy=1 .nr Dy -1    \e" if day!=1, restore original value
\&.+m 1                      \e" add a month
\&.if \e\en(Dy=1 .+d -1        \e" if day==1, subtract a day
\&.Dd                        \e" set due date
\&..
.DE
.SH
Formatting dates
.PP
The format of the registers
.CW Yr
and
.CW Wy
is initially set to
.CW 0001
(4 digits), and of
.CW Mo ,
.CW Dy
and
.CW Wk
to
.CW 01
(2 digits).
.PP
The strings
.Cb Df
and
.Cb Ds
control the date format and separator used by
.CW .Fd .
Their default values are
.Cq \e\en(Dy\e\e*(Ds\e\en(Mo\e\e*(Ds\e\en(Yr
and
.Cq . ,
making the format
.CW dd.mm.yyyy .
.\" Double backslashes make the values interpolated when the string is referenced.
Double backslashes interpolate the referenced values when
.CW Df
is evaluated.
The related macros are:
.RS
.Ma .Di
.Qu "Date \*(Is" ): (
Set
.CW Df
and
.CW Ds
to
.Cq \e\en(Yr\e\e*(Ds\e\en(Mo\e\e*(Ds\e\en(Dy
and
.Cq -
to use the \*(Is date format
.CW yyyy-mm-dd .
.Ma .Fd string
Format a numeric date, storing the result in
.I string .
The default implementation calls
.CW .Sr
and sets
.I string
to the value of
.CW Df .
.\" It is sufficient for most use cases.
The user may reimplement
.CW .Fd
when this is insufficient.
.RE
.\" .PP
.\" A custom implementation may be provided to change the format.
.PP
.I Example:
Use \*(Is week date format with
.Cq \-
separators, e.g.,
.CW 2025\-W01\-2
for 2024-12-31.
.DS
.CW
\&.ds Df \e\en(Wy-W\e\en(Wk-\e\en(Wd
.DE
.PP
.I Example:
Format the date as
.Cq "Www,\ d\ Mmm\ yyyy" ,
e.g.,
.Cq "Sun,\ 5\ Jan\ 2025" .
.DS
.CW
\&.af Dy 1  \e" reset format of Dy to clear minimum width
\&.ds Df \e\e*(Ws, \e\en(Dy \e\e*(Ms \e\en(Yr
.DE
.SH
Footer customisation
.PP
Footer fields are customisable.
The string
.CW /A
sets the footer title.
Strings
.CW /B
to
.CW /M
set field titles on the left (first column),
.CW /N
to
.CW /Y
on the right (third column),
.CW /b
to
.CW /y
the corresponding values (second and fourth columns).
A field is printed if
its value string has positive width
(that's troffese for
.Qu length ).
.PP
Default settings are listed in
.I "Appendix B" .
Double backslashes interpolate the referenced values
during evaluation.
The list of fields has gaps for easier customisability.
.PP
.I Example:
Print a different name above the bank account details,
the original name in bold above the address, move the
.Cq Address:
title one line up and put an empty(-looking) line above it.
.DS
.CW
.\" \&.\e" /c: set value to the company name
\&.ds /c B\e(:ose Leute e.V.
.\" \&.\e" /p: insert an empty(-looking) line above the address
\&.ds /p \e|
.\" \&.\e" /q: set title to "Address:" and value to the name in bold
\&.ds /Q \e*(/R
\&.ds /q \efB\e\e*(Nm\efP
.\" \&.\e" /r: clear field title
\&.ds /R
.DE
.SH
Bespoke
.Cb \-ms
footers
.PP
.CW \-minv
overrides
.CW .BT
to prevent printing both footers on the same page.
.\" For bespoke
.\" .CW \-ms
.\" footers like the one on this
Instead,
.Cb .Bt
becomes the macro to redefine for more complex
.CW \-ms
footers in invoices,
as it was done here.\& \c
.rn Bt Xb
.de Bt
.rn Xb Bt
.af Dy 1
.af Yr I
.tl @\fIPage \n% special!\fP@\\n(Dy \\*(Ml \\n(Yr@\fIDraws!  Leaves!\fP\
\k(;x\v'-0.2v'\h'1n'\z\D'P 1.5n -0.3n 0 0.6n'\h'1n'\
\D'l 1n+1m 0'\D'l 0 \n(.du-\\n(.du'\D'l \n(.ku-\\n(.lu-2m 0'\
\h'|\\n(;xu'@
.af Dy 01
.af Yr 0001
..
.\" page, the user can redefine the
.\" .Cb .Bt
.\" macro instead.
.SH
Title\*(Me
.\" .PP
.\" To print a title so that it fits above the safety area,
.\" .CW \-minv
.\" supplements
.\" .CW .TL
.\" from
.\" .CW \-ms
.\" with its own facility for titles.
.\" It is useful not only at the top of the title page,
.\" but also later in the document.
.RS
.Ma .Tl \fR[\fCsafe\fP]
Print a title.
With
.Cq safe ,
if the title is too long,
.\" if the title would end below the top of the
.\" .Qu "safety area"
.\" around the address (more than one line with default settings),
printing is delayed until after
.CW .Ae .
.Ma .Te
End the title.
May be omitted before
.CW .Bo
or
.CW .Ad .
.RE
.SH
Box\*(Me
.PP
A
box
is a narrow display block
.\" (around 35 ens or 6.2 cm with default settings)
to the right of the address.
.\" Boxes work better if used before
.\" .CW .Ad .
Subsequent boxes appear below previous ones.
If a box ends below the address display,
it will push the position set by
.CW .Ae
downwards.
Likewise, a long header may displace boxes.
.RS
.Ma .Bo \fR[\fPstyle\fR]
.\" .Ma .Bo \
.\" [\f(CILF\fP\||\f(CIF\fP\||\f(CIC\fP\||\f(CIR\fP\||\f(CIRF\fP][\f(CIN\fP]
Start a box block.
The style is [\c
.CW LF \^|\^\c
.CW F \^|\^\c
.CW C \^|\^\c
.CW R \^|\^\c
.CW RF ][\c
.CW N ].
.\" The style is one of
.\" .CW N ,
.\" .CW R ,
.\" .CW RN ,
.\" .CW C
.\" or
.\" .CW CN .
The default is left-adjusted, unfilled, boxed.
.CW L ,
.CW C
and
.CW R
set adjustment to left, centre or right,
.CW F
enables filling,
.CW N
omits the enclosing box.
.\" .Ma .Bh string
.\" Print a box header.
.Ma .Hs
Draw a horizontal separator.
Also useful outside the box.
.Ma .Be
End a previous box, invoice header or address block.
May be omitted before
.CW .Bo
or
.CW .Ad .
.RE
.SH
Signature\*(Me
.RS
.Ma .Sl "above below \fR[\fCfull\fP\^|\^\fCno\fP]"
Draw a signature line with
.I above
printed five lines above and
.I below
in italic under.
.Cq no ,
omits the line,
.Cq full ,
makes it longer.
.\" If immediately followed by another
A second
.CW .Sl
.\" call, the second line will be printed to its right,
will place the line to its right.
.RE
.SH
Setting tax amounts manually
.PP
Items with round gross prices may introduce rounding errors.
E.g., to expense 15 \*(Eu including 19% \*(Va,
charging neither 12.60 nor 12.61 \*(Eu
will result in the correct total amount.
Charging 12.605 \*(Eu will, with the price printed as 12.61,
but doing it twice will make the net total look illogical:
.Tax 19
.\" .Set fmt %.3f
.Charge 12.605 1 Ticket Going there
.Charge 12.605 1 Ticket Coming back
.\" .Set fmt %.2f
.Set warn 0
.End
.Set warn 1
.PP
One way to fix it is to
.CW ".Set\ fmt\ %.3f"
before the charges, possibly restoring it to
.CW %.2f
.\" before the end of the table.
after.
Another is to set tax amounts for these charges manually
using
.Cb .Taxed .
.\" \|command immediately before
.\" .CW .Charge .
.BI
Ask your accountant what to do.
.PP
A
.Cb .Taxed
\|command immediately preceding
.CW .Charge
sets the tax amount for the charge.
.DS
.CW
.\" \&.Tax 19
\&.Taxed 2.39
\&.Charge 12.61 1 Ticket Going there
.\" \&.Taxed 2.39
.\" \&.Charge 12.61 1 Ticket Coming back
.DE
.SH
\*(MeDealing with
.ft CB
\&.AM
.PP
.\" Attempting to use
Using
.CW .AM
before
.CW .Ae
will end in tears, because the latter clashes with the string
.CW Ae
defined by the former.
.\" .CW .AM
.\" is disabled before
.\" .CW .Ae ,
.\" as it defines the string
.\" .CW Ae ,
.\" clashing with it.
.Cb .Am
without arguments
restores the original behaviour of
.CW .AM .
.\" necessitating the use of
.\" .CW .Ea
.\" instead of
.\" .CW .Ae .
.Cq ".Am\ keep"
modifies it to rename the
.CW Ae
string to
.CW Af
and keep the
.\" .CW .Ae
macro.
.CW .Be
can be used instead of
.CW .Ae
regardless.
.ig
.CW .Am 's
effect is permanent, thus it removes itself once it's invoked.
.CW .Ae
invokes it without arguments.
can be invoked only once.
..
.CW .Am
can only be called once,
whereupon it removes itself.
.\" after that it has no effect.
.CW .Ae
calls it without arguments.
.Tl
Appendix A: Example letter
.Te
.PP
.\" The result is shown on the next page.
.rn Be ;e
.de Be
.LP
.rn ;e Be
..
.de Xw
.wh \n(HMu-1
.so nitama-letter.t
.\" .I [...]
.Hs
..
.wh \n(HMu-1 Xw
.ID \" \n(PIu
.\" .ps -1
.\" .vs -1
.CW
.so nitama-letter.p
.\" .I [...]
.DE
.Tl
Appendix B: Macros, strings and number registers
.Te
.\" .SH
.\" Naming convention
.PP
Neither troff nor
.CW \-ms
(except
.CW .AM )
use names consisting of one uppercase and one lowercase letter.
.CW -minv
and
.CW -mail
use names matching
.CW [+0\-9A\-WYZ_][a\-z]
and
.CW [\-/][A\-Za\-z]
for their
.Sc API ,
and
.CW [';][A\-Za\-z]
internally.
Names matching
.CW X[a\-z]
and
.CW [a\-z][A\-Z]
are explicitly reserved for the user.
.if t \{\
.2C
.sp -\n(PDu \}
.KS
.PP
Configuration strings:
.TS
li lix li
lfC l li .
Name	Description	Notes\h'2'\&
1a\*(Me	Address line 1	[a] [f] \fR\(dg
2a\*(Me	\b'\(rt\(bv\(rk\(bv\(rb' Address lines 2\-6	[a] [f]
3a	\^	\^
4a	\^	\^
5a	\^	\^
6a	\^	\^
Af\*(Me	T{
.ad l
Address font (default:
.CW C )
T}	[a]
Ba	Bank name	[f]
Bi	\*(Bc	[f]
Bl	Bankleitzahl	[f]
Cu	Currency	[t] \fR\(dd
Df	Date format	[h]
Ds	Date separator	[h]
Ib	\*(An	[f]
Nf\*(Me	T{
.ad l
Name font in address (default:
.CW CB )
T}	[a]
Nm\*(Me	Name	[a] [f] \fR\(dg
Sa\*(Me	Sender address font	[a]
Sn\*(Me	Sender name font	[a]
Ta	Tax authority	[f]
Tn	Tax number	[f]
.TE
.KE
.KS
.PP
\*(MpConfiguration registers:
.TS
li lix li
lfC l li .
Name	Description	Notes\h'2'\&
Cf	Configuration flags
Rs	Recipient address font size	[a]
Ss	Sender address font size	[a]
.TE
.KE
.KS
.PP
Configuration flags register\*(Mp
.CW Cf :
.TS
li lix li
l l li .
Value	Description	Notes\h'2'\&
1	Compact sender address	[a]
2	Draw fold lines	[a]
.\" 4	T{
.\" .ad l
.\" \k(;x\h'-2n'\d\s-3\b'\(rt\(rk\(rb'\s0\u\h'|\n(;xu'\
.\" Reduce recipient address font
.\" size by
.\" 1\(en3 points
.\" .\" 1, 2 or 3 points
.\" .I "value\ " "\(di\ 2)" (
.\" T}	[a]
.\" 8	\^	\^
.TE
.KE
.KS
.PP
Configuration macros:
.TS
li lix li
lfC l li .
Name	Description	Notes\h'2'\&
\&.Am	Choose behaviour of \fC.AM\fP\*(Me
\&.Di	Use \*(Is date format	[h]
.TE
.KE
.KS
.PP
.I Notes:
.sp \n(PDu
.de Xi
.sp -\n(PDu
.IP "\h'2.5n-\w'\\$1'u/2u'\\$1" 4n
..
.Xi \(dg 4n
Mandatory
.Xi \(dd
Mandatory for invoices
.Xi \fI[a]\fP \\*(Me
Used by
.CW .Ad
.br
.sp -1
\*(Me
.Xi \fI[f]\fP
Used by the footer
.CW .Ft , (
.CW .In )
.Xi \fI[h]\fP
Used by the header
.CW .Ih , (
.CW .In )
.Xi \fI[t]\fP
Used by the invoice table
..
.KE
.sp 0.5
.KS
.PP
User defined macros (optional):
.TS
li li
lfC l .
Name	Description
\&.Bt	Replacement for \fC\-ms .BT
\&.Cd	Calculate due date
\&.Fd	Format date
.TE
.KE
.KS
.PP
Defined macros:
.LP
.CW
.nf
\&.+d	.+m	.Ad	.Ae	.Am	.As	.Be	.Bh
\&.Bo	.Dd	.Di	.Ea	.En	.Fd	.Fo	.Ft
\&.Hd	.Hs	.Id	.Ih	.In	.Pa	.Ps	.Se
\&.Sl	.Sr	.Te	.Tl	.We
.KE
.sp 0.5
.KS
.PP
Footer customisation strings:
.so vars
.TS
li li li
lfC lfC l .
Name	Default	Description
_
/A	\*(/A	\fC/A\fP: Footer title
		\_
.T&
lfC lfC l
lfC lfC ^ .
/C	\*(/C	T{
.nf
Left side:
\fC/B\fP \- \fC/M\fP: titles
\fC/b\fP \- \fC/m\fP: values
T}
/c	\*(/c
/F	\*(/F
/f	\*(/f
/G	\*(/G
/g	\*(/g
/H	\*(/H
/h	\*(/h
/I	\*(/I
/i	\*(/i
		\_
.T&
lfC lfC l
lfC lfC ^ .
/N	\*(/N	T{
.nf
Right side:
\fC/N\fP \- \fC/Y\fP: titles
\fC/n\fP \- \fC/y\fP: values
T}
/n	\*(/n
/o	\*(/o
/R	\*(/R
/r	\*(/r
/s	\*(/s
/t	\*(/t
/u	\*(/u
/v	\*(/v
/w	\*(/w
		\_
.TE
.KE
.KS
.PP
Date registers:
.TS
li li li
lfC l l .
.
Name	Description	Range
Dy	Day	1 \- 31
Mo	Month	1 \- 12
Yr	Year	1 \- \(if
Wd	\*(Is week day	1 \- 7
Wk	\*(Is week	1 \- 53
Wy	\*(Is week date year	1 \- \(if
.TE
.KE
.KS
.PP
Strings set by
.CW .Sr :
.TS
li li li
lfC l lfC .
Name	Description	Example
Ml	Long month name	\*(-A
Ms	Short month name	\*(-a
Wl	Long week day name	\*(-S
Ws	Short week day name	\*(-s
.TE
.KE
.KS
.PP
Date strings:
.TS
li li
lfC l .
Name	Description
Da	Invoice date
Du	Due date
.TE
.KE
.KS
.PP
Strings set by the invoice table:
.TS
li lix
lfC l .
Name	Description
Ne	Total net amount
To	Total amount
Tx	Total tax
.TE
.KE
.KS
.PP
Customisation / localisation strings:
.\" .ds Cu \e\e*(Cu
.TS
li li
lfC lfC .
Name	Default
_a	\*(_a
_b	\*(_b
_c	\*(_c
_d	\*(_d
_e	\*(_e
_f	\*(_f
_i	\*(_i
_j\*(Me	\fR\h'-\w'\(lq'u'\(lq\fP\*(_j\fR\(rq\fP \fI(return address joiner)\fP
_k	\*(_k
_l	\*(_l
_m	\*(_m
_n	\*(_n
_o	\*(_o
_p	\*(_p
_q	\*(_q
_r	\*(_r
_s	\*(_s
_t	\*(_t
_u	\*(_u
_v	\*(_v
_w	\*(_w
-A \fR\-\fC -L	\*(-A \fR\-\fC \*(-L
-M \fR\-\fC -S	\*(-M \fR\-\fC \*(-S
-a \fR\-\fC -l	\*(-a \fR\-\fC \*(-l
-m \fR\-\fC -s	\*(-m \fR\-\fC \*(-s
.TE
.KE
.Lh
Appendix C: Small print
.nr PS -2
.nr VS -2
.LP
.Li
.nr PS +2
.nr VS +2
