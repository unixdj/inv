.In 2024001 16.03.2024
.Ad "Client GmbH"
Geile Str. 0
00000 Gutdorf
.Ae
.DS
.CW
\&.Tax 19
\&.Charge 12.605 1 Ticket Going there
\&.Charge 12.605 1 Ticket Coming back
.DE
.Tax 19
.Charge 12.605 1 Ticket Going there
.Charge 12.605 1 Ticket Coming back
.tm inv: \n(.F:\n(.c: == !!! Expect a warning !!!
.End
.tm inv: \n(.F:\n(.c: == ... Stop expecting warnings ...
.DS
.CW
\&.Tax 19
\&.Set fmt %.3f
\&.Charge 12.605 1 Ticket Going there
\&.Charge 12.605 1 Ticket Coming back
\&.Set fmt %.2f
.DE
.Set fmt %.3f
.Charge 12.605 1 Ticket Going there
.Charge 12.605 1 Ticket Coming back
.Set fmt %.2f
.End
.DS
.CW
\&.Tax 19
\&.Taxed 2.39
\&.Charge 12.61 1 Ticket Going there
\&.Taxed 2.39
\&.Charge 12.61 1 Ticket Coming back
.DE
.Taxed 2.39
.Charge 12.61 1 Ticket Going there
.Taxed 2.39
.Charge 12.61 1 Ticket Coming back
