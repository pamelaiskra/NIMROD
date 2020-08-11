From the .asc files created (raw files), rasters have to be multiplied times 1/(32*12) because
"a value of 1 in an array location corresponds with 1/32 of a mm of rain per hour (valid for the 5-minute 
reference period)."

Beispiel:

Cell value: 15

      1   mm *  1 hr                    1    mm
15 * ---- --   ------ * 5 min  = 15 * ------ -- = 0,039 mm
      32  hr   60 min                  32*12 hr