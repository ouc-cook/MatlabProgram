function flag=istfr2(method);
% flag=istfr2(method) returns true is method is a
% time frequency representation of type 2 (only positive frequencies).
%	See also istfr1, istfraff.

%	F. Auger, may 98
%	Copyright (c) CNRS - France 1998. 
%
%	------------------- CONFIDENTIAL PROGRAM -------------------- 
%	This program can not be used without the authorization of its
%	author(s). For any comment or bug report, please send e-mail to 
%	f.auger@ieee.org 

method=upper(method);
if strcmp(method,'TFRWV'   ) | strcmp(method,'TFRPWV'  ) | ...
   strcmp(method,'TFRSPWV' ) | strcmp(method,'TFRCW'   ) | ...
   strcmp(method,'TFRZAM'  ) | strcmp(method,'TFRBJ'   ) | ...
   strcmp(method,'TFRBUD'  ) | strcmp(method,'TFRGRD'  ) | ...
   strcmp(method,'TFRRSPWV') | strcmp(method,'TFRRPWV' ) | ...
   strcmp(method,'TFRRIDB' ) | strcmp(method,'TFRRIDH' ) | ...
   strcmp(method,'TFRRIDT' ) | strcmp(method,'TFRASPW' ) | ...
   strcmp(method,'TFRDFLA' ) | strcmp(method,'TFRSPAW' ) | ...
   strcmp(method,'TFRRIDBN') | strcmp(method,'TFRUNTER') | ...
   strcmp(method,'TFRBERT' ) | strcmp(method,'TFRSCALO') | ...
   strcmp(method,'TFRSPBK' ) | strcmp(method,'TYPE2'   ),
 flag=1;
else
 flag=0;
end;

