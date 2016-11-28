# BrokenUSB
### Small PowerShell utility I created for dumping documents from a USB thumb drive

## What even is this? like... wtf?
Well, I work in a school and are constantly faced with students bringing me a dead USB thumb drive and a sad face. It always contains their most important work eva in t3h entire universe (it is of course the only copy they had of said super important work...). Anyways! This was designed for a particular task in mind. Usually I am able to get these USB thumb drives mildly functional with some well placed solder, tightly wrapped eletrical tape and some good thumb positioning, however this makes it difficult to beging copying the files across as both my hands are tied holding the thumb drive in the perfect position so that windows recognises and mounts the volume.

What this script does is wait for insertion of a USB Storage Device, upon detection it will scan the removable storage device for filetypes from a predetermined list, plus any extra filetypes specified through command line arguments and dumps them to an output folder.

## Usage

This script has 2 command line arguments:
```
-OutDir
-FileTypes
```

Both pretty self explanatory, -OutDir is a mandatory argument where you point your output directory for the extracted files and -FileTypes is an optional argument for specifying additional filetypes you would like extracted.

## Example

> .\BrokenUSB.ps1 -OutDir E:\recover\ -FileType \*.mod,\*.png,\*.efi
