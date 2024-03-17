.In 2024001
.Ad "Client GmbH"
Geile Str. 0
00000 Gutdorf
.Ae
.PP
.I Example:
Add service period (\(lq\f(CIMonth yyyy\fP\(rq) to the
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
.+d -14
.Sr
.Charge 100 8 Hours Mindless keyboard bashing, \*(Ml \n(Yr
