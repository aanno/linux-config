#!/bin/bash -x

#k2pdfopt v2.36 (w/MuPDF,DjVuLibre,OCR) (c) 2016, GPLv3, http://willus.com
#    Compiled Nov 26 2016 with Gnu C v4.8.5 for Linux on x64.
#
# a. Autostraighten (-as)                 n. Native PDF output (-n)
# b. Bitmap type (-jpg,-png,-bpc)         o. Output name (-o)
#bp. Break pages (-bp,-f2p)              oc. OCR (-ocr,-ocrvis,...)
# c. Color/Negative output (-c, -neg)    om. Output margins (-om)
#co. Column detection (-col,-ch,...)      p. Page range (-p)
#cs. Contrast/Sharpen (-cmax,-g,-s,-wt)  pd. Padding/Marking (-p[lrbt],-mc)
# d. Device selection (-dev,-h,-w,-dpi)   r. Right-to-left page scans (-r)
#ds. Document scale factor (-ds)         rt. Rotate source page (-sr)
# f. Fit to single column (-fc)           s. Special (-de,-evl,-gs)
#gt. Gap thresholds (-gt...)             sm. Show marked source (-sm)
# j. Justification (-j)                   u. Usage (command line opts)
# l. Landscape mode (-ls)                 v. Vertical spacing (-vb,-vs)
# m. Margin to ignore (-m)                w. Wrap/Reflow text (-wrap,-ws)
#mo. Mode (-mode)                         x. Exit on completion (-x)

# k2pdfopt age.pdf -ui- -w 560 -h 735 -dpi 150 -as -col 2 -ac -sm -o k2try.pdf

#Selected options:  Reactive_Machine_Learning_Systems_v1_MEAP.pdf -as -w 1404 -h 1872 -dpi 300 -idpi -2 -mode def -o mls.pdf -ow -1
#
#Enter option above (h=help, q=quit): 
#
#
#** You have specified -odpi, -mag, or -fs.  This may not work as expected unless you also turn off the "fit-column-to-device" option by specifying -fc-.  (You can disable this message by specifying -y.) **                                                 
#
#Reading 93 pages from Reactive_Machine_Learning_Systems_v1_MEAP.pdf ...

K2PDFOPT="/home/tpasch/bin/k2pdfopt"

OPTS="-as -w 1404 -h 1872 -idpi -2 -ow -1 -ui- -x -o "
# OPTS="-as -w 1404 -h 1872 -idpi -2 -dpi 300 -fc- -ow -1 -ui- -x -o "
IN=$1
shift

$K2PDFOPT "$IN.pdf" $* $OPTS "$IN-k2.pdf"
