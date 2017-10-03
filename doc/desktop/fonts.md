# Fonts unter Linux

## Font-Probleme

Viele Font-Darstellungsprobleme auf einem Linux-Desktop können bereits durch 
eine angepasste Konfiguration behoben werden, da mittlerweile gute freie 
Alternativen zu MS-Windows-Fonts in den neuen Distributionen mit ausgeliefert 
werden. 

Es kann nämlich vorkommen (z.B. bei Ubuntu), dass für bestimmte 
Font-Familien "ungünstige" Fonts zurückgegeben werden. Mit der Datei 
`~/.config/fontconfig/fonts.conf` können einfach Regeln erstellt werden, 
die die vorgegebenen Systemregeln zur Fontsuche überschreiben und dadurch 
die gewünschten Fonts zurückgeben. 

Eine Beispieldatei, die sich unter Ubuntu bewährt hat, befindet sich im Anhang: 
fonts.conf: Fontconfig-Datei mit Regeln (nicht nur) für Ubuntu

Weitere Quellen zu Font-Problemen mit Lösungen:

* Probleme mit Calibri und Cambria (2 Fonts, die MS mit neuen Office Paketen 
  liefert): [Lösung](https://wiki.debian.org/SubstitutingCalibriAndCambriaFonts)
* Standard MS-Fonts nicht installiert oder unleserlich: 
  [Lösung](http://www.pcworld.com/article/2863497/how-to-install-microsoft-fonts-in-linux-office-suites.html) 

## Anhang

### `fonts.conf`

```xml
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
 <match target="font">
  <edit mode="assign" name="rgba">
   <const>rgb</const>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="hinting">
   <bool>true</bool>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="hintstyle">
   <const>hintmedium</const>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="antialias">
   <bool>true</bool>
  </edit>
 </match>
 <match target="font">
  <test name="family">
   <string>DejaVu Sans Mono</string>
  </test>
  <test compare="less" name="pixelsize">
   <double>7.5</double>
  </test>
  <edit name="hinting">
   <bool>false</bool>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="embeddedbitmap">
   <bool>false</bool>
  </edit>
 </match>
 <match target="pattern">
	 <test qual="any" name="family"><string>Helvetica Condensed</string></test>
	 <edit name="family" mode="assign" binding="same"><string>Liberation Sans Narrow</string></edit>
 </match>
 <match target="pattern">
	 <test qual="any" name="family"><string>Helvetica</string></test>
	 <edit name="family" mode="assign" binding="same"><string>Liberation Sans</string></edit>
 </match>
 <match target="pattern">
	 <test qual="any" name="family"><string>Times</string></test>
	 <edit name="family" mode="assign" binding="same"><string>Liberation Serif</string></edit>
 </match>
 <match target="pattern">
	 <test qual="any" name="family"><string>Courier</string></test>
	 <edit name="family" mode="assign" binding="same"><string>Liberation Mono</string></edit>
 </match>
 <match target="pattern">
	 <test qual="any" name="family"><string>sans-serif</string></test>
	 <edit name="family" mode="assign" binding="same"><string>Liberation Sans</string></edit>
 </match>
 <dir>~/.fonts</dir>
</fontconfig>
```
