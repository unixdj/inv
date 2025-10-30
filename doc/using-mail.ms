.\" Copyright (c) 2024 Vadim Vygonets <vadik@vygo.net>
.\"
.\" Permission to use, copy, modify, and distribute this software for any
.\" purpose with or without fee is hereby granted, provided that the above
.\" copyright notice and this permission notice appear in all copies.
.\"
.\" THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
.\" WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
.\" MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
.\" ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
.\" WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
.\" ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
.\" OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
.\" =============================================================
.so macs
.DA "26 April 2024"
.nr HY 0
.if !'\*(Ix'' \{\
.de ix
.ie '\\n(.z'' .tm ix: \\$1 \\$2 \\$3 \\$4 \\$5 \\$6 \\$7 \\$8 \\$9\t\\n%
.el \\!.ix \\$1 \\$2 \\$3 \\$4 \\$5 \\$6 \\$7 \\$8 \\$9
..
.\}
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
.ix [\\$1]~macro
..
.de Re
.IP "\f(CB\\$1"
.ix [\\$1]~register
..
.de St
.IP "\f(CB\\$1"
.ix [\\$1]~string
..
.TL
Writing Letters with
.Cb \-mail
Macros
.AU
Vadim Vygonets
.AB no
The
.CW \-mail
troff macro package is an add-on to
.CW \-ms
for writing letters.
.\" The macros provide facilities for formatting the address block
The macros provide facilities for formatting the address block
and using the limited space around it.
.PP
.CW \-mail
started as part of
.CW \-inv
macros for formatting invoices,
but was separated when the author discovered
that there exist other kinds of letters.
.PP
The main part of this document
describes the macros and basic configuration.
The appendices go into details
of address block placement and formatting,
the theory behind it,
how it's derived from paper and envelope dimensions,
and fine tuning thereof.
.AE
.de Xw
.wh \n(HMu-1
.ev 1
.ps 10
.vs 12
.so letter.t
.Hs
.sp
.ev
.ds Xg \\n%
..
.wh \n(HMu-1 Xw
.SH
Basic usage
.PP
The full source of a typical letter might look like this:
.DS B
.CW
.so letter.p
.DE
.PP
To build it, put
the files
.CW inc/tmac.ail ,
.CW mail/conf.t
and
.CW mail/Makefile
from the source repository
and a file ending with
.CW .ms
containing the source in the same directory and run
.CW make .
The output from the source above can be seen on
.ie '\*(Xg'' the next page.
.el .ie '\*(Xg'\n%' this page.
.el page \*(Xg.
.PP
The sender address would normally be set in a configuration file.
.\" .CW conf.t ,
.\" automatically included before the source,
.\" rather than in the source file itself.
For frequent correspondents
you might also want to put the address block in a separate file
and include it with \" a troff request such as
.Ic recipient .t ".so\ " .
.PP
The configuration file
.CW conf.t
is included before the source.
The default search path used for
the macro file and included files is
.CW .:inc:../inc:${HOME}/.ail .
The search path and the configuration file name
can be changed by setting the environment variables
.CW $AILPATH
and
.CW $AILCONF .
.SH
Address block
.ix address~block
.PP
The strings
.CW Nm ,
.CW 1a ,
.CW 2a ,
.CW 3a ,
.CW 4a ,
.CW 5a
and
.CW 6a
.ix [Nm]~string
.ix [1a]~string
.ix [2a]~string
.ix [3a]~string
.ix [4a]~string
.ix [5a]~string
.ix [6a]~string
define the sender name and up to 6 lines of address.
At least
.CW Nm
and
.CW 1a
must be set.
The related macros are:
.RS
.PP
.Ma .As "name line1 \fR[\fPline2 \fR[\fPline3 \fR[\fPline4 \fR[\fPline5 \fR[\fPline6\fR]]]]]
If
.I name
is not empty, set
.CW Nm
to
.I name .
Clear
.CW 1a ,
.CW 2a \|...\|\c
.CW 6a
and set them to
.I line1 \(en\c
.I line6 .
.\" the rest of the arguments.
.Ma .Ad name
End any active block and
start the address definition with
.I name
as the recipient name.
.\" Lines that follow will be added to the address.
.\" .PP
.Ma .Ae
End the address definition,
print the address where it's visible through an envelope window
and set the position below the window.
For compatibility with
.CW .AM
from Berkeley and
.Sc GNU
.CW \-ms ,
.CW .Be
can be used instead of
.CW .Ae .
.RE
.PP
That's it.
This is all you
.I really
need to know.
.if \n(.d*4/3-\n(.p .bp
.SH
Address block configuration
.PP
This section only describes basic configuration.
Positioning is discussed in the
section
.I "Page layout configuration" .
.PP
A number of strings and registers control address fonts.
.TS
center;
li li li li
lfC l lfC l .
Name	R/S	Default	Description
Af	String	C	Address font
.ix [Af]~string
.ix font
Nf	String	CB	Name font
.ix [Nf]~string
Rs	Register	10	Recipient address font point size
.ix point size
.ix [Rs]~register
Rv	Register		Recipient address vertical spacing; unset \(== \fCRs\fP
.ix vertical spacing
.ix [Rv]~register
Sa	String	\e\e*(Af	Sender address font (default references \fCAf\fP)
.ix [Sa]~string
Sn	String	\e\e*(Nf	Sender name font (default references \fCNf\fP)
.ix [Sn]~string
Ss	Register	6	Sender address font point size
.ix [Ss]~register
Sv	Register		Sender address vertical spacing; unset \(== \fCSs\fP
.ix [Sv]~register
.TE
.PP
The register
.Cb Cf
.ix [Cf]~register
.ix configuration flags
is a bit field of configuration flags.
.TS
center;
li li li
l l l .
Bit	Value	Description
0	1	Always print sender address in compact form
1	2	Draw fold lines
.TE
.SH
Using the space around the address block
.PP
Although most printing macros
can be used independently from each other,
using them in the recommended order achieves the best results.
.PS
.\" scale = 2.54
.\" boxwid = 1.8
boxwid = 0.71
movewid = 0.45
linewid = movewid
boxht = 0.39
moveht = boxht
circlerad = boxht / 2
All: [
.I
Start: line "start" above
# line up 0.16 invis
line up 0.05 invis
.CW
arrow from 0.65 <Start.s, Start.e> down moveht \
	then right 0.4 * movewid
Tl: box ".Tl"
arrow from 0.4 <Tl.ne, Tl.se> 2 * boxwid 2.7 * movewid \
	then down 2.5 * moveht \
	then left 3 * boxwid 3 * movewid \
	then down 0.2 * moveht \
	then right 0.3 * movewid
arrow from 0.45 <Start.s, Start.e> down 2.5 * moveht \
	then right 0.6 * movewid
Hd: box ".Hd" ; move ; Bo: box ".Bo" ; arrow ; Hs: box ".Hs"
arrow from 0.4 <Hd.ne, Hd.se> right 0.25 * movewid \
	then down 0.5 * moveht \
	then to 0.9 <Bo.nw, Bo.sw>
arrow from 0.6 <Hd.ne, Hd.se> right 0.15 * movewid \
	then down 0.5 * moveht \
	then left boxwid 0.75 * movewid \
	then down 1.1 * moveht \
	then right 0.6 * movewid
arrow from 0.3 <Bo.ne, Bo.se> right 0.3 * movewid \
	then up 0.5 * moveht \
	then left boxwid 0.65 * movewid \
	then to 0.1 <Bo.nw, Bo.sw> - 0.35 * movewid, 0 \
	then to 0.1 <Bo.nw, Bo.sw>
arrow from 0.3 <Hs.ne, Hs.se> right 0.3 * movewid \
	then up 0.5 * moveht \
	then left boxwid 0.7 * movewid \
	then to 0.3 <Hs.nw, Hs.sw> - 0.4 * movewid, 0 \
	then to 0.3 <Hs.nw, Hs.sw>
arrow from Hs.e right 0.5 * movewid \
	then up 0.9 * moveht \
	then left 2 * boxwid 1.95 * movewid \
	then to 0.3 <Bo.nw, Bo.sw> - 0.45 * movewid, 0 \
	then to 0.3 <Bo.nw, Bo.sw>
arrow from 0.7 <Hs.ne, Hs.se> right 0.5 * movewid \
	then down 0.6 * moveht \
	then left 3 * boxwid 2.9 * movewid \
	then down 0.5 * moveht \
	then right 0.4 * movewid
arrow from 0.7 <Bo.ne, Bo.se> right 0.5 * movewid \
	then down 0.5 * moveht \
	then left 2 * boxwid 2 * movewid \
	then down 0.8 * moveht \
	then right 0.5 * movewid
box ".Ad" ; arrow ; box ".Ae"
.I
arrow ; box "any text or\^" "troff \f(CI-ms\fP" dashed
arrow ; circle "end\^"
circle with .c at last circle .c radius circlerad - 0.03
.CW
arrow from 0.35 <Start.s, Start.e> down 4.4 * moveht \
	then right 0.7 * movewid
arrow from 0.55 <Start.s, Start.e> down 1.75 * moveht \
	then right 0.85 * movewid boxwid \
	then to 0.7 <Bo.nw, Bo.sw> + -0.65 * movewid, 0 \
	then to 0.7 <Bo.nw, Bo.sw>
arrow from 0.6 <Tl.ne, Tl.se> right 0.45 * movewid \
	then to Bo.w + -0.55*movewid,0 \
	then to Bo.w
]
.B
"Recommended flow" at All.n
.PE
.PP
The address block is not huge,
but the empty
.Qu "safety area"
around it is quite extensive,
for reasons explained in
.I "Appendix A" .
In particular, with the default configuration
the space between the top margin and the top of the safety area
is 7.6 mm, or about 21.5 points,
which is less than two lines with 12 point vertical spacing.
.SH
Blocks
.ix block
.PP
.Qu Block
is a term used for a span of text started by a
.CW \-mail
macro.
Other than that they don't have much in common.
The four types of blocks are
.I Address ,
.I Box ,
.I Header
and
.I Title .
.SH
Title
.ix title
.PP
To print a title so that it fits above the safety area,
.CW \-mail
supplements
.CW .TL
from
.CW \-ms
with its own facility for titles.
It is useful not only at the top of the title page,
but also later in the document.
.RS
.Ma .Tl \fR[\fCsafe\fR]
Format the title in a 12 point bold font,
with lines filled to 5/6 of the current line length
and each line centered but not adjusted.
When called at the top of a page,
no space is output before the title,
in order to fit one-line titles before the address box.
With
.Cq safe ,
if the title would end below the top of the safety area,
printing is delayed until after
.CW .Ae .
.Ma .Te
End the title.
Other macros that end the title are
.CW .Ad ,
.CW .Be ,
.CW .Bo ,
.CW .Hd
and
.CW .Tl
itself.
Attempting to start a new paragraph without it will not work.
.RE
.SH
Header
.ix header
.PP
The header is a right-adjusted, unfilled display
at the top right, used by
.CW \-minv
for invoice number and date.
.RS
.Ma .Hd \fR[\fPheader\fR]\fP
Start the header block at the top right.
If
.I header
is given, print it in 16 point bold font.
Must be ended with
.CW .Ad ,
.CW .Be ,
.CW .Bo ,
.CW .Hd
or
.CW .Tl .
.RE
.SH
Box
.ix box
.PP
A
box
is a narrow display block
(around 35 ens or 6.2 cm with default settings)
to the right of the address.
Such blocks are often used in official letters
for metadata, such as reference numbers.
.PP
The first box on a page is aligned with the address block,
subsequent boxes appear below previous ones.
If a box ends below the address display,
it will push the position set by
.CW .Ae
downwards.
Likewise, a long header may displace boxes.
.PP
If the box ends above the position from which
.CW .Bo
was called, the original vertical position is restored.
.RS
.Ma .Bo \fR[\fPstyle\fR]\fP
Start a box block.
The style is [\c
.CW LF \^|\^\c
.CW F \^|\^\c
.CW C \^|\^\c
.CW R \^|\^\c
.CW RF ][\c
.CW N ].
The default is left-adjusted, unfilled, boxed.
.CW C
and
.CW R
make the lines centered or right-adjusted,
.CW LF
and
.CW RF
make them left- or right-adjusted and filled,
.CW F
makes them filled and adjusted at both margins.
.CW N
omits drawing the enclosing box.
.Ma .Bh string
Print a box header.
.Ma .Be
End the active block, if any.
If the first page has not started, call
.CW .LP .
If neither is true,
.CW .Be
is a no-op.
It is called by block-starting macros
.CW .Ad ,
.CW .Bo ,
.CW .Hd
and
.CW .Tl .
.RE
.SH
Other
.RS
.Ma .Hs
Draw a horizontal separator.
.Ma .Sl "above below \fR[\fCfull\fP\^|\^\fCno\fP]"
Draw a horizontal line of 3/8 line length with
.I above
printed five lines above it and
.I below
in italic immediately under it.
If the third argument is
.Cq no ,
the line itself is not drawn;
if it's
.Cq full ,
the line is of 3/4 line length.
The signature line is printed at the left margin.
If immediately followed by another
.CW .Sl
call, the second line will be printed to its right,
unless the third argument of either is
.Cq full .
.Cq ".Sl\ """"\ """"\ no"
can be used to skip a line on either side.
.RE
.SH
Dealing with
.ft CB
\&.AM
.PP
.ix [.Ae]~macro
Attempting to use
.CW .AM
before
.CW .Ae
will end in tears, because the latter clashes with the string
.CW Ae
defined by the former.
Because of this,
.CW .AM
is disabled until the first
.CW .Ae
call.
A macro is provided to reenable and configure
.CW .AM .
.RS
.Ma .Am \fR[\fCkeep\fP]
Restore the original behaviour of
.CW .AM .
With
.Cq keep ,
modify it to rename the
.CW Ae
string to
.CW Az
.ix [Az]~string
and keep the
.CW .Ae
macro.
.CW .Am
can only be called once,
whereupon it removes itself.
.\" after that it has no effect.
.CW .Ae
calls it without arguments.
.RE
.nr Cf 2
.ds Xg
.di Xu
.\" .EQ L
`1 u = 1 over 1000 ^ pt = 1 over 72000 ^ in mark = 352 {^7^} over 9 ^ nm`
.br
.\" .EN
.di
.de Xw
.wh \n(HMu-1
\&
.Xl
.Hd "\f(CB\-mail\fP Page Layout"
.Bo
.fi
.ti +\\n(PIu
Paper sizes \" are stored
and layout configuration \" calculations are done
are internally handled
in \(*mm.
Layout configuration registers and calculations
are in troff units \fCu\fP.
In groff that is:
.sp 0.25
.Xu
.rm Xu
.sp 0.5
.ti +\\n(PIu
This allows paper sizes over 757 m, or 0.47 mi,
an order of magnitude more than a typical ancient scroll.
.Be
.As Sender Address
.Ad Recipient
Address
.Ae
Bare text starts here
.Hs
.ds Xg \\n%
..
.wh \n(HMu-1 Xw
.Tl
Page layout
.ix page layout
.Te
.PP
The title page layout is centered around the address,
which is printed where it will be visible through an envelope window.
.\" Subsequent sections describe how the placement of the address box
.\" is derived from envelope geometry.
.\" .PP
The placement of the address block
.\" described in detail in subsequent sections,
is controlled by a number of registers,
whose values are in troff units
.CW u ). (
.ix troff~unit [u]
.ie '\*(Xg'' The next page
.el .ie '\*(Xg'\n%' This page
.el Page \*(Xg
shows their effect on the layout.
.KS
.TS
center;
li li ri ci
lfC l r c .
Name	Description	Default	Formula
_
.Fs \n(Ag
Ag	Address bottom gap	\*(Sz mm
.ix [Ag]~register
.Fs \n(Ah
Ah	Address height	\*(Sz mm	`h sv`
.ix [Ah]~register
.Fs \n(Ai
Ai	Address horizontal indent	\*(Sz mm
.ix [Ai]~register
.Fs \n(Aj
Aj	Address vertical indent	\*(Sz mm
.ix [Aj]~register
Al	Address alignment	\n(Al\h'\w' mm'u'
.ix [Al]~register
.Fs \n(Ap
Ap	Address height+	\*(Sz mm	`h sx`
.ix [Ap]~register
.Fs \n(Av
Av	Address vertical extension	\*(Sz mm
.ix [Av]~register
.Fs \n(Aw
Aw	Address width	\*(Sz mm	`w sv`
.ix [Aw]~register
.Fs \n(Ax
Ax	Address horizontal position	\*(Sz mm	`x sv`
.ix [Ax]~register
.Fs \n(Ay
Ay	Address vertical position	\*(Sz mm	`y sv`
.ix [Ay]~register
.Fs \n(Fl
Fl	Fold line default vertical position	\*(Sz mm	`y sub L`
.ix [Fl]~register
.Fs \n(Fm
Fm	Fold line maximum vertical position	\*(Sz mm	`y sub M`
.ix [Fm]~register
.Fs \n(Sh
Sh	Safety area height	\*(Sz mm	`h ss`
.ix [Sh]~register
.Fs \n(Sw
Sw	Safety area width	\*(Sz mm	`w ss`
.ix [Sw]~register
.Fs \n(Sx
Sx	Safety area horizontal position	\*(Sz mm	`x ss`
.ix [Sx]~register
.Fs \n(Sy
Sy	Safety area vertical position	\*(Sz mm	`y ss`
.ix [Sy]~register
.\" Ph	Paper height	`h sp`
.\" Pw	Paper width	`w sp`
.TE
.KE
.PP
The
.I Formula
column specifies the value assigned to the register by
.CW .Pa
and
.CW .En ;
see
.I "Appendix A"
for details.
The registers listed below can only be set manually.
The effect of
.CW Ai
can be seen on
.ie '\*(Xg'' the next page,
.el .ie '\*(Xg'\n%' this page,
.el page \*(Xg,
others are explained in
.I "Appendix B" .
.RS
.Re Ag
Minimum gap after the recipient address.
With top alignment the gap is disregarded
when centering the address within the block.
Otherwise equivalent to adding vertical space
at the bottom of the recipient address.
.Re Ai
Offsets the left edge of address horizontally from
.CW Ax .
.\" Negative values have no effect.
.Re Aj
Adds vertical space on top of the sender address.
.Re Al
Controls vertical alignment of the address in the block.
Legal values are 0 for top aligned (address overflows downwards),
1 for centered (address overflows both ways) and
2 for bottom aligned (address overflows upwards).
Should not be used with folded paper, such as A4 in a
.Sc C6/C5
envelope.
.Re Av
Address vertical extension / additional `V` height.
Changes the layout for paper folded lower
by at least the specified distance, increasing effective
.CW Ah
and
.CW Fl .
.\" E.g., for A4 in a
.\" .Sc C6/C5
.\" envelope folded at 110 mm or lower instead of the default 99 mm,
.\" set
.\" .CW Av
.\" to 11 mm:
.\" .Cq ".nr\ Av\ 1.1c" .
Should not be used with unfolded paper, such as A4 in a C4 envelope.
.CW Fm
takes precedence over `font C Fl + font C Av` for drawing fold lines.
.RE
.SH
Paper and envelope sizes
.ix %begin paper~and envelope sizes
.PP
Named paper and envelope sizes can be used as macro arguments
instead of raw dimensions.
The name may be followed by
.Cq R
to switch width and height
.I R otate (
90\(de).
.PP
Several
.Sc DIN
sizes are predefined.
Those with both dimensions of at least 210 mm
are in portrait orientation, the rest in landscape,
presuming the use case of
unfolded or horizontally folded A4 paper in portrait orientation
in an envelope.
.\" without distinction between paper and envelopes.
.\" Predefined paper sizes are:
.KS
.TS
center; li ri , lfC r .
Name	`Width times Height`
_
A4	`210 times 297 mm`
A5	`210 times 148 mm`
B4	`250 times 353 mm`
B5	`250 times 176 mm`
C4	`229 times 324 mm`
C5	`229 times 162 mm`
C6/C5	`229 times 114 mm`
DL	`220 times 110 mm`
.TE
.KE
.SH
Layout configuration macros
.PP
The macros derive the layout from given paper and envelopes,
with sizes referred to by name as described above
or specified directly.
All measurements are in millimetres;
for more precision use fractions like
.Qu 12345/100 .
.\" The macros should be called in the order
.\" in which they're listed in this section.
Macros should be called in the order
they're listed.
.RS
.Ma .Ps "name w h"
Define paper/envelope size
.I name
of width
.I w
and height
.I h .
Up to 26 sizes in total can be defined.
.Ma .Pa "\fR[\fCauto\fP | \fIname\fR [\fCR\fP] | \fIw h\fR]"
Reset layout configutation registers and set paper size.
If no arguments are given, the current paper size is kept.
If the argument is
.Cq auto ,
the paper size is derived from troff registers
.CW .l ,
.CW .o
and
.CW .p .
The resulting configuration is unusable without calling
.CW .En
at least once.
.Ma .En "\fR(\fPname \fR[\fCR\fP] |\fI W H\fR\^)\fP w h x y"
Constrain register values
according to envelope and window dimensions.
The arguments
.I name
.CW R ] [
or
.I W
and
.I H
are the envelope size;
.I w ,
.I h ,
.I x
and
.I y
specify the size of the window and its position
relatively to the top left corner.
For convenience,
envelopes with width equal to the paper's
or height dividing that of the paper equally
are explicitly allowed,
those narrower than the paper are not.
.ix %end paper~and envelope sizes
.\" All dimensions are in millimetres.
.Ma .Fo "name \fR[\fCR\fP] | \fIH"
.ix fold~lines
Set fold lines for the named envelope,
or for an envelope of height
.I H .
Only needed with configurations based on several envelope sizes,
to override the default choice.
.RE
.SH
Default configuration
.\" .PP
.\" The defaults are based on two arbitrary envelopes.
.DS
.CW
\&.Pa A4
\&.En C6/C5 90 52 25 48
\&.En C6/C5 90 44 20 53
\&.nr Ai 0.3c
.DE
.bp
.Tl
Appendix A: Deriving the Layout
.Te
.ix %begin page layout
.SH
Theory
.PP
The layout is based on the assumptions that the paper
is inserted into the envelope folded along the horizontal axis
the exact number of times needed to fit there (which may be zero),
with the top part at the front,
in such way that no part of the paper extends beyond its top edge.
For a paper folded twice (like A4 in a
.Sc C6/C5
envelope)
this would mean that the first fold is
no less than a third of paper length
and no more than the height of the envelope
from the top,
and the second at most twice that distance.
.PP
With paper moving around in an envelope,
the area visible through the window changes.
For our purpose it's more useful to view it
as the envelope moving relative to the paper.
.PP
The location of the window is measured from the top left corner.
When the paper is in that corner, we call the envelope position
.Qu "(at) origin" .
When it's in the opposite corner, we call it
.Qu "(fully) displaced" .
.PP
The picture below shows A4 paper folded in thirds
(at 99 mm from the top) in a
.Sc C6/C5
envelope with a `90 times 44 mm` window
at the coordinates 20 (right), 53 (down) mm,
at 1:2 scale.
.PP
The
.Qu "always visible"
.ix always visible area
area, which can be seen through the window
regardless of the position of the envelope relative the paper,
is shaded.
The
.Qu "safety area"
.ix safety area
around it, marked with a dotted line,
is the parts that may come into view.
.LP
.PS
scale = 50.8
pwid = 210
pht  = 99
ewid = 229
eht  = 114
dx   = ewid - pwid
dy   = eht - pht
wwid = 90
wht  = 44
wx   = 20
wy   = 53
A4: box wid pwid ht pht
"99 mm " rjust above at A4.se
box with .nw at A4.nw + wx, -wy wid wwid-dx ht wht-dy invis fill 0.5
# box with .sw at Win.sw wid wwid-dx ht dy invis fill 0.2
# Env: box dashed wid ewid ht eht with .nw at A4.nw
right
line dashed from A4.ne right dx then down eht
line dashed left ewid \
    "\s-1C6/C5\s0 envelope with paper at top left (\(lqorigin\(rq)" \
    above
line dashed up dy
line dashed 1 left dx then up eht
Dis: line dashed 1 right ewid \
    "\s-1C6/C5\s0 envelope with paper at bottom right (\(lqdisplaced\(rq)" \
    above
line dashed 1 down dy
# Dis: box dashed 1 1.5 same with .se at A4.se
Dwi: box dashed 1 1.5 wid wwid ht wht with .nw at Dis .s + wx, -wy
Win: box dashed same with .nw at A4.nw + wx, -wy
line dotted 1 from Dwi.ne right dx then down dy
line dotted 1 from Dwi.sw down dy then right dx
"A4 folded at one third" above at A4.n
# "\s-1C6/C5\s0 envelope with paper at top left (\(lqorigin\(rq)" \
# 	above at Env.s
# "\s-1C6/C5\s0 envelope with paper at bottom right (\(lqdisplaced\(rq)" \
	# above at Dis.n
"Window (origin)" above at Win.n
"Window (displaced)" above at Dwi.n
.PE
.KS
.PP
.ix fold~lines
Folding the paper lower reduces vertical displacement.
The picture below shows the paper folded at the height of the envelope
(114 mm), with the original
.Qu "always visible"
area shown as above, and the addition lightly shaded.
The dotted line marks the original safety area.
.LP
.PS
scale = 50.8
pwid = 210
pht  = 99
ewid = 229
eht  = 114
dx   = ewid - pwid
dy   = eht - pht
wwid = 90
wht  = 44
wx   = 20
wy   = 53
A4: box wid pwid ht eht
"114 mm " rjust above at A4.se
box with .nw at A4.nw + wx, -wy wid wwid-dx ht wht-dy invis fill 0.5
box with .sw at A4.nw + wx, -wy - wht wid wwid-dx ht dy invis fill 0.2
Env: box dashed wid ewid ht eht with .nw at A4.nw
Dis: box dashed 1 1.5 same with .se at A4.se
Dwi: box dashed 1 1.5 wid wwid ht wht with .nw at last box .nw + wx, -wy
Win: box dashed same with .nw at A4.nw + wx, -wy
"\s-1C6/C5\s0 envelope" "A4 folded at envelope height" at A4.n
"(origin) " rjust above at Env.ne
" (displaced)" ljust above at Dis.nw
"Window" above at 0.5 <Dwi.nw, Win.ne>
"(origin) " rjust above at Win.ne
" (displaced)" ljust above at Dwi.nw
line dotted from A4.nw + 0, -99 right pwid
"99 mm " rjust above
line dotted 1 from Dwi.nw up dy then right wwid dx then down dy
"Safety area" above at Dwi.nw + (wwid + dx) / 2, dy
.PE
.KE
.KS
.PP
Envelope windows are not standardised.
Here are the same areas for a
.Sc C6/C5
envelope with a `90 times 52 mm` window
at 25, 48 mm,
with paper folded at envelope height.
.LP
.PS
scale = 50.8
pwid = 210
pht  = 99
ewid = 229
eht  = 114
dx   = ewid - pwid
dy   = eht - pht
wwid = 90
wht  = 52
wx   = 25
wy   = 48
A4: box wid pwid ht eht
box invis fill 0.5 with .nw at A4.nw + wx, -wy wid wwid - dx ht wht - dy
box invis fill 0.2 with .n at last box .s wid wwid - dx ht dy
box dotted 1 with .nw at A4.nw + wx - dx, dy - wy wid wwid + dx ht wht + dy
"Safety area" above at last box .n
line dotted from A4.nw + 0, -99 right pwid
"99 mm " rjust above
"114 mm " rjust above at A4.se
.PE
.KE
.KS
.PP
The intersection between
.Qu "always visible"
areas of with the two envelopes,
with the originals marked by dashed lines,
and the combined safety area:
.LP
.PS
scale = 50.8
pwid = 210
pht  = 99
ewid = 229
eht  = 114
dx   = ewid - pwid
dy   = eht - pht
w1wid = 90
w1ht  = 44
w1x   = 20
w1y   = 53
w2wid = 90
w2ht  = 52
w2x   = 25
w2y   = 48
A4: box wid pwid ht eht
box invis fill 0.5 with .nw at A4.nw + w2x, -w1y \
	wid w2wid - dx + w1x - w2x ht w1ht - dy
box invis fill 0.2 with .n at last box .s wid w2wid - dx + w1x - w2x ht dy
box dashed 1 with .nw at A4.nw + w1x, -w1y wid w1wid - dx ht w1ht - dy
box dashed 1 with .n at last box .s wid w1wid - dx ht dy
box dashed with .nw at A4.nw + w2x, -w2y wid w2wid - dx ht w2ht - dy
box dashed with .n at last box .s wid w2wid - dx ht dy
line dotted 1 from A4.nw + w2x - dx, dy - w2y right w2wid + dx + w1x - w2x \
	"Safety area" above
line dotted 1 right w2x - w1x \
	then down w2ht + dy \
	then left w2wid + dx \
	then up w2y + w2ht - w1y - w1ht \
	then left w2x - w1x \
	then up w1ht + dy \
	then right w2x - w1x \
	then up w1y - w2y
line dotted from A4.nw + 0, -pht right pwid
"99 mm " rjust above
"114 mm " rjust above at A4.se
.PE
.KE
.KS
.PP
The areas are:
.TS
center tab(:);
li s ri ri ri ri ri ri
li l r r r r r r .
Area:x:y:width:height:right:bottom
_
V:Always visible with fold at 99 mm:25:53:66:29:91:82
X:Extension of \fIV\fP with fold at 114 mm:25:82:66:15:91:97
S:Safety (bounding box):1:33:114:67:115:100
.TE
.KE
.KS
.PP
In a C4 envelope the paper is not folded, thus the
.I X
area does not apply.
Below is the
.I V
area for a C4 envelope with a `90 times 55 mm` window at 20, 57 mm
marked with a solid line, its
.I S
area with a dotted line, the
.I V
and
.I X
areas from the previous drawing marked with dashed lines,
and the combined areas shaded.
.PS
scale = 50.8
pwid = 210
pht  = 99
ewid = 229
eht  = 114
dx   = 19 # ewid - pwid
dy   = 27 # eht - pht
w1wid = 90
w1ht  = 55
w1x   = 20
w1y   = 57
A4: box invis wid pwid ht eht
line from A4.nw down eht 7
line dotted 2 down 15
line down 10 then right pwid
"297 mm " rjust above
line up 10
line from A4.nw right pwid then down eht 7
line dotted 2 down 15
box invis fill 0.5 with .nw at A4.nw + w2x, -w1y \
	wid w2wid - dx + w1x - w2x ht w2ht - dy
box invis fill 0.2 with .nw at last box .sw \
	wid w2wid - dx + w1x - w2x ht w1y + w1ht - dy - 53 - 29
box with .nw at A4.nw + w1x, -w1y \
	wid w2wid - dx ht w1ht - dy
line dotted from A4.nw + 0, -pht right pwid
"99 mm " rjust above
line dotted from A4.sw right pwid
"114 mm " rjust above
box dashed with .nw at A4.nw + 25, -53 wid 66 ht 29
# box dashed with .nw at A4.nw + 25, -53 wid 76 ht 29
box dashed 1 with .nw at A4.nw + 25, -82 wid 66 ht 15
box dotted 1 with .nw at A4.nw + w1x - dx, dy - w1y wid w1wid + dx ht w1ht + dy
"Safety area" above at last box .n
.PE
.PP
Applying this would reduce the height of `V+X` to 28 mm.
This is too extreme, so we ignore it for the default settings.
.KE
.bp
.SH
Calculation
.PP
To calculate the areas
.\" `S` (safety),
.\" `V` (always visible) and
.\" `X` (always visible extension)
`S`, `V` and `X`
for paper of size `w sp ~ times ~ h sp`
suitable for `n` `roman envelopes from i=1 to n`,
each of size `W si times H si`
with a `w si times h si` window
at `x si , y si`,
apply the following formulae:
.LP
.nr Xd \n(.d
.sp |\n(Xdu
.po +\n(.lu/2u
.ll -\n(.lu/2u
.nr LL -\n(.lu
.EQ L "(number of times paper is folded)"
~~~~~~~~~ t si mark = left floor h sp over H si right floor
.EN
.EQ L "(default fold line)"
l sj lineup = h sp over { j + 1 }
.EN
.nr Xd \n(.d
.EQ L "(vertical displacement)"
Delta y si lineup = H si - l sti
.EN
.EQ L
y ss lineup = min fin ~ (y si - Delta y si )
.EN
.EQ L
b ss lineup = max fin ~ (y si + h si )
.EN
.EQ L
h ss lineup = b ss - y ss
.EN
.EQ L
y sv lineup = max fin y si
.EN
.EQ L
b sv lineup = min fin ~ (y si + h si - Delta y si )
.EN
.EQ L
h sv lineup = b sv - y sv
.EN
.EQ L
y sx lineup = b sv
.EN
.EQ L
b sx lineup = min fin left {
lpile { y si + h si above y si + h si - Delta y si ~~ }
lpile { if ~ t si > 0 above if ~ t si = 0 }
.EN
.EQ L
h sx lineup = b sx - b sv
.EN
.nr Xe \n(.d
\&
.sp |\n(Xdu
.sp -\n(PDu*16/10
.nr LL
.po
.EQ L "(horizontal displacement)"
~~~~~~Delta x si mark = W si - w sp
.EN
.EQ L
x ss lineup = min fin ~ (x si - Delta x si )
.EN
.EQ L
r ss lineup = max fin ~ (x si + w si )
.EN
.EQ L
w ss lineup = r ss - x ss
.EN
.EQ L
x sv lineup = max fin x si
.EN
.EQ L
r sv lineup = min fin ~ (x si + w si - Delta x si )
.EN
.EQ L
w sv lineup = r sv - x sv
.EN
.EQ L
x sx lineup = x sv
.EN
.EQ L
w sx lineup = w sv
.EN
.ll \n(.lu*2u
.nr LL \n(.lu
\&
.sp |\n(Xeu
.ig
.SH
Safety area
.PP
In
.CW \-minv
the top and left boundaries of the safety area are ignored.
The right boundary affects the location of the box
.CW .Bo ), (
and the bottom boundary the placement after
.CW .Ae .
For each envelope, the area is extended 5 mm in both directions.
Then, to avoid folding through the top of the text,
if the bottom boundary is
within 24 mm from the edge of the envelope,
it is extended down to 1 mm past the edge,
making the total extension 5\(en30 mm.
.PP
For these purposes the formulae for the safety area edges
are modified thusly:
.\" .EQ
r ss = max fin ~ (x si + w si +5 mm )
~~~~~~~~~~~~~~~~
b ss = max fin left {
lpile { H si + 1 mm above y si + h si + 5 mm ~~ }
lpile {
if ~ H si - y si - h si ~ \(mo        ~ [4 mm , 29 mm ] above
if ~ H si - y si - h si ~ "\o'/\(mo'" ~ [4 mm , 29 mm ] }
.\" .EN
..
.SH
Fold lines
.ix fold~lines
.PP
If bit 1 (value 2) of
.CW Cf
.ix [Cf]~register
is set and
.CW Fl
.ix [Fl]~register
is less than the page height,
two sets of fold lines will be drawn.
.\" .PP
With envelopes grouped
by the number of times the paper is folded to fit into (`t si`),
the default fold line is of the group with largest `t` value.
.EQ
T = max fin t si
~~~~~~~~~~~~~~~~
y sub L = l sub T
.EN
.PP
The maximum (lowest) fold line is set to the largest height
of any envelope in the group.
.\" .EQ
.\" y sub M = max fin left {
.\" lpile { H si ~~ above 0 }
.\" lpile { if ~ t si = T above if ~ t si != T }
.\" .EN
.EQ
y sub M = max fin left {
H si ~|~ i ~: t si = T right }
.EN
.PP
E.g., with a configuration based on
.Sc C4
(`t si = 0`),
.Sc C5
(`t si = 1`), and
.Sc DL
and
.Sc C6/C5
(`t si = 2`) envelopes,
the fold lines are set based on the tallest envelope
in the last group,
.Sc C6/C5 .
.PP
With printed address of height `h sub A`,
the location of the first fold line `y sub F` is at `y sub L`
if the address fits vertically in the `V` area,
otherwise it is lowered by the height of the overflow,
but no lower than `y sub M`.
The second fold line is at twice the distance
from the top of the paper, `2 y sub F`.
A warning is printed
if the overflow is larger than `y sx`.
.ix %end page layout
.EQ
y sub F = left {
lpile {
y sub L above
y sub L + h sub A - h sv ~~ above
y sub M }
lpile {
if ~ h sub A - h sv < 0 above
if ~ 0 <= h sub A - h sv <= y sub M - y sub L above
if ~ h sub A - h sv > y sub M - y sub L
}
.EN
\&
.bp
.ig
.SH
Post-\f(CB.Ae\fP placement
.PP
The default text placement is at `b sx`.
When the address is too long, the text will be pushed down
to keep the distance between them at least 5 mm.
.\" A long address will push it down
.\" to keep the distance of at least 5 mm.
.\" .EQ
y sub P = left {
lpile { y sx above y sv + h sub A + 5 mm ~~ }
lpile {
if ~ y sv + h sub A + 5 mm <= y sx above
if ~ y sv + h sub A + 5 mm > y sx }
.\" .EN
..
.\" .ds _j " \(bu \"
.As
.ds Nm Sender
.ds 1a Address line 1
.\" .ds 2a Address line 2
.\" .ds 3a Address line 3
.\" .ds 4a Address line 4
.\" .ds 5a Address line 5
.\" .ds 6a Address line 6
.Tl safe
Appendix B: Recipient address placement
.Te
.ix %begin address~block layout
.Ad "\(:Ubergeile Leute"
Address
.Ae
.PP
.ix [Al]~register
With top alignment (`font C Al = 0`), given enough space,
the recipient address is placed
in the middle of the space below the sender address (`alpha = beta`).
When the address display is bottom-aligned (`font C Al = 2`),
the `beta` gap is above the sender address;
when the display is centered (`font C Al = 1`),
it's split in two, above and below.
.PP
This document describes gap values in terms of
top-aligned address display.
Unless noted otherwise,
the calculations are equivalent for other alignments,
only the placement of the `beta` gap differs.
.LP
.nr Xx \n(Ax
.nr Xy \n(Ay
.nr Xd \n(.du+4v
.Xb "" \&
.sp |\n(;Ru
.sp \n(;Ru-\n(Ayu-\n(Ahu-\n(Avu+24p
\h'\n(Axu-\n(.ou-0.7c'\c
.\" \h'-0.2c'
.z- 2 30
.^v \n(Ayu+\n(Ahu+\n(Avu-\n(;Ru-22p*10u+0 \(*a
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.\" \v'20p'\c
.z- 2 30
.^v \n(Ayu+\n(Ahu+\n(Avu-\n(;Ru-22p*10u+0 \(*b
.z- 2 30
.nr Ay \n(Xdu+4v
.nr Al +1
.[] \\n(Awu*10u+0 \\n(Ahu*10u+0 \\n(Axu*10u+0 \\n(Ayu*10u+0
.Ad "\(:Ubergeile Leute"
Centered Address
.Ae
.\" .nr Ax +\n(.lu/2u+\n(.ou
.nr Ax \n(.lu+\n(.ou-\n(Awy
.nr Al +1
.[] \\n(Awu*10u+0 \\n(Ahu*10u+0 \\n(Axu*10u+0 \\n(Ayu*10u+0
.Ad "\(:Ubergeile Leute"
Bottom-Aligned Address
.Ae
.nr Ax \n(Xxu
.nr Ay \n(Xyu
.nr Al 0
.bp
.ds 2a Address line 2
\&
.Bo
`1 pt = 1 over 72 ^ in = 352 {^7^} over 9 ^ um`
.sp 1p
.Ad "Recipient"
Address
Address
Address
Address
.Ae
.PP
When the addresses take too much space,
the recipient address starts being pushed down,
initially keeping the gap of 10 pt (over 3.5 mm) between them.
.LP
.Xb
.vs 0
.ps 1
.sp |\n(;Ru-8p
\h'\n(Axu-\n(.ou-0.7c'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
.\" .sp |8.2c
.\" \h'0.2c'\c
.\" .z- 2 50
.\" .|| 3
.\" .|| 5 "10 pt"
.\" .|| -8
.\" .^v -3.52777777777777
.\" .\" .^v -3.88055555555555
.\" .z- 2 50
.\" .|| -5
.bp
.\" .ds 2a Address line 2
.ds 3a Address line 3
.\" .ds 4a Address line 4
.ds 4a
.ds 5a
.\" .ds 6a Address line 6
\&
.Ad Recipient
Address
Address
Address
Address
.Ae
.PP
At some point the address bumps against the bottom
of the `V` area and the gap starts closing.
.LP
.vs 0
.ps 1
.[] \\n(Awu*10u+0 \\n(Ahu*10u+0 \\n(Axu*10u+0 \\n(Ayu*10u+0
.sp |\n(;Ru-8p
\h'\n(Axu-\n(.ou-0.7c'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
\v'10p'\c
.z- 2 30
.\" .z- 2 50
.\" .|| 5
.\" .|| 5 "8 pt"
.\" .|| -10
.\" .^v -2.82222222222222
.\" .z- 2 50
.\" .|| -5
.\" .sp |\n(;Ru
.\" .z- 2 50
.bp
.ds 4a
.ds 5a
.\" .ds 6a Address line 6
.ds 2a Address line 2
.ds 3a Address line 3
.ds 4a Address line 4
.ds 5a Address line 5
.\" .ds _j " \v'-0.2'.\v'0.2' \"
.LP
.Ad Recipient
Address
Address
Address
.Ae
.PP
The gap never shrinks below 6 pt.
Before the address overflows the
.Qu "Always visible"
area,
the sender address will collapse into compact form,
if it wasn't already.
This is what happened to the Nitama letter in
.I "Appendix A"
of the
.CW \-minv
manual.
.PP
Setting bit 0 (value 1) of the
.CW Cf
.ix [Cf]~register
register forces compact sender address.
.LP
.vs 0
.ps 1
.[] \\n(Awu*10u+0 \\n(Ahu*10u+0 \\n(Axu*10u+0 \\n(Ayu*10u+0
.bp
\&
.ds Nm Sender Name
.\" .ds 3a Line 3
.\" .ds 4a Line 4
.ds 4a
.ds 5a
.ds 6a
.\" .so ../inc/conf.t
.\" .ds _j " \(bu \"
.\" .ds _j " \v'-0.2'.\v'0.2' \"
.Ad "Station master Nitama"
Kishi Station
Wakayama Electric Railway
3-4-32, Kishichou
Tondabayashi-shi
Osaka-fu 584-0005
Japan
.Ae
.PP
Speaking of which, that address still overflows the area.
.PP
Setting bit 1 (value 2) of the
.CW Cf
.ix [Cf]~register
register, as was done for this document,
enables drawing fold lines.
.ix fold~lines
Upper fold lines are normally drawn at the distance from the top
specified by the
.CW Fl
.ix [Fl]~register
register.
If a top-aligned or centered address overflows from the bottom,
the lines are drawn lower,
but not below the value of
.CW Fm .
.ix [Fm]~register
Lower fold lines are drawn at twice the distance from the top.
.PP
To summarise, the sizes of the gaps
between sender and recepient addresses (`alpha`)
and between the latter and the end of area `V` (`beta`)
depend on the total available space
`gamma = alpha + beta`:
.LP
.ta 17n 28n
.nf
.in 8n
`20 pt <= mark gamma`	`alpha = beta = half gamma`
`10 pt <= lineup gamma <= 20 pt`	`alpha = 10 pt`	`beta = gamma - 10 pt`
`6 pt <= lineup gamma <= 10 pt`	`alpha = gamma`	`beta = 0 pt`
`lineup gamma <= \06 pt`	`alpha = 6 pt`	`beta = gamma - 6 pt`
.in 0
.PS
scale = 10
arrow dotted 0.25 from 0, -12 to 0, 18
"\(*a, \(*b  " rjust below
arrow dotted 0.25 from -10, 0 to 37, 0
"\(*g    " "" rjust above
"\(*a  " rjust at -8, 6
line to 6,6 then to 10, 10 then to 20, 10 # then to 30, 15
line to 30, 15
" `alpha = beta`" ljust
"\(*b  " rjust at -5, -11
line dashed to 6, 0 to 10, 0 to 20, 10 # to 30, 15
"`gamma over 2` " rjust at -8, -4
line dotted 0.5 to 30, 15
# line dotted from -8, -8 to 6, 6
# line dotted from 10, 10 to 15, 15
# " \(*g" ljust
"6\|" rjust below at 0, 6
line from 0.5, 10 to -0.5, 10
"10\|" rjust
# line dotted to 10, 10
"0\|" rjust below at 0, 0
line from 0.5, -6 to -0.5, -6
"-6\|" rjust
line from 6, 0.5 to 6, -0.5
# "6\|" rjust below
"6" below
line from 10, 0.5 to 10, -0.5
"10" below
# line dotted to 10, 10
line from 20, 0.5 to 20, -0.5
"20" below
# line dotted to 20, 10
.I
line dotted 0.5 from 6,-12 to 6,18
" \v'3p'compact sender addresses only" ljust below \
" left of this line (\(*g\| < 6\^)" ljust below
.PE
.PP
This example also demonstrates a special case
(which also happens in the example in the manual):
if the sender name and address don't fit on one line,
but the address alone does, the name is printed on its own line.
Compare to the previous page.
.\" .LP
.Xb
.Xf
.sp |\n(;Ru-4p
\h'\n(Axu-\n(.ou-0.7c'\c
.z- 2 40
.z| 5 10
.|v
\v'6p'\c
.z- 2 40
.|^
.|| 3
.|| 5 "6 pt"
.bp
.LP
\&
.nr Rs 10
.nr Ag 0.2c
.nr Aj 0.1c
.nr Av 1.0c
.\" .ds 4a Address line 4
.Ad "Station master Nitama"
Kishi Station
Wakayama Electric Railway
3-4-32, Kishichou
Tondabayashi-shi
Osaka-fu 584-0005
Japan
.Ae
.PP
This page shows the effect of setting three registers:
.DS
.CW
\&.nr Ag 0.2c
\&.nr Aj 0.1c
\&.nr Av 1c
.ix [Ag]~register
.ix [Aj]~register
.ix [Av]~register
.DE
.PP
If
.CW Al
is 0, setting the address gap
.CW Ag
to `delta` changes the values of `alpha` and `beta`
when `6 pt < gamma < delta + 10 pt` as shown.
With other alignments it's fully equivalent to
adding vertical space after the address.
.LP
.ta 23n 34n
.nf
.in 8n
`~~~~~~20 pt <= mark gamma`	`alpha = beta = half gamma`
`10 pt + delta <= lineup gamma <= 20 pt`	`alpha = 10 pt`	`beta = gamma - 10 pt`
`6 pt + delta <= lineup gamma <= 10 pt + delta`	`alpha = gamma`	`beta = delta`
`lineup gamma <= \06 pt + delta`	`alpha = 6 pt`	`beta = gamma - 6 pt`
.in 0
.PS
.\" .ps 9
scale = 10
arrow dotted 0.25 from 0, -12 to 0, 18
"\(*a, \(*b  " rjust below
arrow dotted 0.25 from -10, 0 to 37, 0
"\(*g    " "" rjust above
"\(*a  " rjust at -8, 6
# line dashed 0.5 to 6,6 then to 10, 10 then to 20, 10 # then to 30, 15
line to 8,6 then to 12, 10 then to 20, 10 # then to 30, 15
line to 30, 15
" \(*a\| \(eq \(*b" ljust
"\(*b  " rjust at -5, -11
line dashed to 8, 2 to 12, 2 to 20, 10 # to 30, 15
"`\(*g over 2` " rjust at -8, -4
line dotted 0.5 to 30, 15
.\" .ps 8
line from 0.5, 2 to -0.5, 2
"\(*d\|" rjust
"6\|" rjust below at 0, 6
line from 0.5, 10 to -0.5, 10
"10\|" rjust
"0\|" rjust below at 0, 0
line from 0.5, -6 to -0.5, -6
"-6\|" rjust
line from 6, 0.5 to 6, -0.5
"6" below
line from 8, 0.5 to 8, -0.5
"6\(pl\(*d" below
line from 12, 0.5 to 12, -0.5
"10\(pl\(*d" below
# line dotted to 10, 10
line from 20, 0.5 to 20, -0.5
"20" below
# line dotted to 20, 10
.I
line dotted 0.5 from 8,-12 to 8,18
" \v'3p'compact sender addresses only" ljust below \
" left of this line (\(*g\| < 6 \(pl \(*d\|)" ljust below
.PE
.LP
.Xb
.Xf
.sp |\n(Ayu+\n(Aju
\h'\n(Axu+-\n(.ou-1.5c'\c
.z| 0 5
.z- 2 38
.Fs \\n(Aju
.^v -\*(Sz
.z- 2 38
.|| -3
.|| -5 "\fCAj\fP: \\*(Sz mm"
\v'0.8c+\n(Ahu+\n(Avu'\c
.z| 0 5
.z- 2 38
.Fs \\n(Agu
.^v -\*(Sz
.z- 2 38
.|| -3
.|| -5 "\fCAg\fP: \\*(Sz mm"
.sp |\n(;Ru-8p
\h'\n(Axu-\n(.ou-0.9c'\c
.z- 2 32
.\" \v'10p'\c
.\" .z- 2 30
.\" \v'10p'\c
.\" .z- 2 40
.z| 5 10
.|v
\v'10p'\c
.z- 2 32
.|^
.|| 3
.|| 5 "10 pt"
.nr Ag 0
.nr Aj 0
.nr Av 0
.ig
.bp
.LP
\&
.\" .ds 2a
.\" .ds 3a
.nr Rs 9
.Ad "Station master Nitama"
Kishi Station
Wakayama Electric Railway
3-4-32, Kishichou
Tondabayashi-shi
Osaka-fu 584-0005
Japan
.Ae
.PP
The recipient address font size can be reduced by setting the
.CW Rs
.ix [Rs]~register
register.
This is how it looks with
.CW ".nr\ Rs\ 9" .
.LP
.Xb
.sp |\n(;Ru-4p
\h'\n(Axu-\n(.ou-0.7c'\c
.z- 2 40
.z| 5 10
.|v
\v'6p'\c
.z- 2 40
.|^
.|| 3
.|| 5 "6 pt"
..
.ix %end address~block layout
.bp
.if '\*(Ix'' \{\
.ie t .so using-mail.ps.ii
.el   .so using-mail.txt.ii \}
