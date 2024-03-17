.TL
\f(CB.Cd\fP example from the tutorial
.PP
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
\&.if !\e\en(Dy==1 .+d 1       \e" if day!=1, add a day
\&.if !\e\en(Dy==1 .nr Dy -1   \e" if day!=1, restore original value
\&.+m 1                      \e" add a month
\&.if \e\en(Dy==1 .+d -1       \e" if day==1, subtract a day
\&.Dd                        \e" set due date
\&..
.DE
.de Cd
.if \\n(Wd>5 .+d 8-\\n(Wd  \" if Sat or Sun, add 2 or 1 days
.Fd Da                     \" format invoice date
.if !\\n(Dy==1 .+d 1       \" if day!=1, add a day
.if !\\n(Dy==1 .nr Dy -1   \" if day!=1, restore original value
.+m 1                      \" add a month
.if \\n(Dy==1 .+d -1       \" if day==1, subtract a day
.Dd                        \" set due date
..
.ds Df \\*(Ws \\n(Yr-\\n(Mo-\\n(Dy
.de Xx
.nr Yr \\$1
.nr Mo \\$2
.nr Dy \\$3
.Fd Xd
.Id \\$1 \\$2 \\$3
..
.DS
.TS
liw20 liw20 liw20
lfC lfC lfC .
Original	Invoice date	Due date
.Xx 2024 02 28
\*(Xd	\*(Da	\*(Du
.Xx 2024 02 29
\*(Xd	\*(Da	\*(Du
.Xx 2024 03 01
\*(Xd	\*(Da	\*(Du
.Xx 2024 03 02
\*(Xd	\*(Da	\*(Du
.Xx 2024 08 31
\*(Xd	\*(Da	\*(Du
.TE
.DE
