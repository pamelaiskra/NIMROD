# NIMROD
Codes process raw radar files from UK's MetOffice NIMROD system

All files were obtained from 
http://data.ceda.ac.uk/badc/ukmo-nimrod/data/composite/uk-1km/2012/

user: pamelaiskra
pass: (the usual, with uppercase and special characters).

1) dowload the metoffice.dat.gz.tar

2) tar -xf metoffice.dat.gz.tar
You will get a single file metoffice.dat.gz

3) gunzip metoffice*.dat.gz
You will get a .dat file for every 5 minutes
(make sure to write the *)

4) run the DATtoASCII file
(no need to change anything).

5) Done.
