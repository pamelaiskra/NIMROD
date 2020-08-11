See file
http://data.ceda.ac.uk/badc/ukmo-nimrod/software/Matlab/ NIMROD_wintest1.m
for units

%   5) For NIMROD composite uk-1km data files, there is just one file in 
%   each *.gz archive file. This contains a snapshot of the entire UK 
%   est Total Precipitation Rate, 1 pixel per 1km square, corresponding 
%   to Ordnance Survey National Grid squares, for a period of 5-minutes. 
%   There is a header of 523 bytes, followed by a rectangular integer array
%   of estimated Precipitation Rates; a value of 1 in an array location 
%   corresponds with 1/32 of a mm of rain per hour (valid for the 5-minute 
%   reference period).

From the .asc files created (raw files), rasters have to be multiplied times 1/(32*12) because
"a value of 1 in an array location corresponds with 1/32 of a mm of rain per hour (valid for the 5-minute 
reference period)."

Beispiel:

Cell value: 15

      1   mm *  1 hr                    1    mm
15 * ---- --   ------ * 5 min  = 15 * ------ -- = 0,039 mm
      32  hr   60 min                  32*12 hr
