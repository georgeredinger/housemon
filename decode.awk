BEGIN { FS=" "}
/^OK/ { print $4*256+$3,(($6*256+$5)/10.0)*1.8+32.0,($8*256+$7),$10*256+$9}

