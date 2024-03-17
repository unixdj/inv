.ds /c B\(:ose Leute e.V. 
.ds /p \|
.ds /Q \*(/R
.ds /q \fB\*(Nm\fP
.ds /R
.de Cq
.CW "\\$1" "\(rq\\$2" "\\$3\(lq"
..
.In 2024001 16.03.2024
.Ad "Client GmbH"
Geile Str. 0
00000 Gutdorf
.Ae
.\" .Tax 19
.\" .Charge 100 8 Hours Mindless keyboard bashing
.\" .Charge 50 2 Hours Playing with oscilloscopes
.I Example:
Print a different name above the bank account details,
the original name in bold above the address, move the
.Cq Address:
title one line up and put an empty(-looking) line above it.
.DS 
.CW
\&.ds /c B\e(:ose Leute e.V. 
\&.ds /p \e|
\&.ds /Q \e*(/R
\&.ds /q \efB\e*(Nm\efP
\&.ds /R
.DE
