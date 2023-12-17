#!/bin/sh
# https://superuser.com/questions/168444/using-ghostscript-to-convert-multi-page-pdf-into-single-jpg

FILE=`basename $1 pdf`

gs -dBATCH -dNOPAUSE -dSAFER -sDEVICE=jpeg -dJPEGQ=95 -r300x300 -dPDFFitPage -dFIXEDMEDIA -sPAPERSIZE=a4\
  -sOutputFile=%03d.jpg $1
ls [0-9]*.jpg
eog 001.jpg &
    
# -dDEVICEWIDTHPOINTS=800
# -dDEVICEHEIGHTPOINTS=600

