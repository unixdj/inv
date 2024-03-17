.\" === Turn hyphenation off (if you want).
.nr HY 0
.\" === If you want a title on top, uncomment the following lines.
.\" .LP
.\" .TL
.\" Title
.\" === Address
.Ad "You!"
Over there!
.Ae
.\" === If you want a title below the address, uncomment the following lines.
.\" .TL
.\" Title
.\" === To follow the title directly with text, uncomment this:
.\" .LP
The manual explains how to use
.CW \-minv
to write a letter.
You should read the
.CW \-ms
manual at
.CW https://troff.org/using-ms.pdf
for more details, but here's a quick start.

You can just write text with empty lines between paragraphs,
like above.
But it doesn't look great.
.LP
Starting a paragraph with
.CW .LP
reduces the gap.
.CW .LP
can also be used to reset formatting.
.PP
A paragraph starting with
.CW .PP
looks even better.
Only the first line is indented.
Subsequent lines start at the left margin.
.SH
This is a section header.
Starts with \f(CB.SH\fP.
.IP "\fC.nr HY 0"
Put this in the beginning to turn hyphenation off.
.IP \fC.br
Line break.
.IP \fC.nf
.nf
"No fill".  Newlines break lines.
A line that is too long will just go on and on uninterrupted \
until it reaches the end of the paper \
and beyond into the outter void.
.IP \fC.fi
Fill mode back on.
.IP \fC.
on its own line does nothing.
.IP \fC\e"
starts a comment until the end of the line.
.IP \fC.\e"
The two combined introduce a comment line.
.IP \fC\e&
prints nothing.
.CW \e&. \(rq \(lq
or
.CW \e&\(aq \(rq \(lq
at the beginning of the line turns the dot or quote into text
instead of introducing a troff command.
.IP \fC\ee
prints a backslash.
.PP
Troff request or macro arguments are separated by whitespace
and optionally enclosed in double quotes.
Use
.CW """""" \(rq \(lq
to insert a double quote character.
.PP
A double quote in the beginning of a string definition
.CW .ds ) (
includes the initial whitespace that follows it.
The value continues until the end of the line.
Following it with
.CW \e" \(rq \(lq
will make the trailing whitespace visible.
