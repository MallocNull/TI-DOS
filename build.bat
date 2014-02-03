@echo off

cd src\00
..\..\tools\spasm base.z80 -DPRIVPAGE=$1C -DRAMMASK=$40
..\..\tools\spasm base.z80 ..\..\0083a.hex -DPRIVPAGE=$1c -DRAMMASK=$40
..\..\tools\spasm base.z80 ..\..\0084a.hex -DPRIVPAGE=$3c -DRAMMASK=$80
..\..\tools\spasm base.z80 ..\..\00SEa.hex -DPRIVPAGE=$7c -DRAMMASK=$80
cd ..\..\
more +1 0083a.hex > 0083.hex
more +1 0084a.hex > 0084.hex
more +1 00SEa.hex > 00SE.hex

cd src\01
..\..\tools\spasm base.z80
..\..\tools\spasm base.z80 ..\..\01a.hex
cd ..\..\
more +1 01a.hex > 01.hex

cd src\privledged
..\..\tools\spasm base.z80
..\..\tools\spasm base.z80 ..\..\priva.hex
cd ..\..\
more +1 priva.hex > priv.hex

tools\multihex 00 0083.hex 01 01.hex 1c priv.hex > os83.hex
tools\packxxu os83.hex -o os83.8xu -t 83p -q 04 -v 0.01 -h 255
tools\rabbitsign -t 8xu -k tools\keys\04.key -K 04 -g -p -r os83.8xu 

tools\multihex 00 0084.hex 01 01.hex 3c priv.hex > os84.hex
tools\packxxu os84.hex -o os84.8xu -t 83p -q 0A -v 0.01 -h 255
tools\rabbitsign -t 8xu -k tools\keys\0A.key -K 0A -g -p -r os84.8xu 

tools\multihex 00 00SE.hex 01 01.hex 7c priv.hex > osSE.hex
tools\packxxu osSE.hex -o osSE.8xu -t 83p -q 0A -v 0.01 -h 255
tools\rabbitsign -t 8xu -k tools\keys\0A.key -K 0A -g -p -r osSE.8xu 

del os83.8xu
del os84.8xu
del osSE.8xu
del *.hex
del *.bin*