https://github.com/BrunoLevy/learn-fpga/blob/master/FemtoRV/TUTORIALS/toolchain_arty.md

##Step 3: nextpnr-xilinx
~~Did not manage to build it with the gui, because on my box it gives a missing symbol error in boost-python, so I deactivated it.~~
```
$ git clone https://github.com/gatecat/nextpnr-xilinx.git
$ cd nextpnr-xilinx
$ git submodule init
$ git submodule update
$ mkdir build
$ cd build
```

Installed these to get gui. what they do idk
```
$ sudo apt-get install libeigen3-dev
$ sudo apt-get install libboost-program-options-dev libboost-iostreams-dev libboost-thread-dev
$ sudo apt-get install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools
```
~~$ cmake ../ -DARCH=xilinx -DBUILD_GUI=OFF -DBUILD_PYTHON=OFF~~
```
$ cmake ../ -DARCH=xilinx -DBUILD_GUI=ON -DBUILD_PYTHON=ON
$ make
$ sudo make install
```

### getting board info ###
```
$ cd nextpnr-xilinx
$ python3 xilinx/python/bbaexport.py --device xc7a35tcsg324-1 --bba xilinx/xc7a35t.bba
$ build/bbasm --l xilinx/xc7a35t.bba xilinx/xc7a35t.bin
$ sudo mkdir -p /usr/share/nextpnr/xilinx-chipdb
$ sudo cp xilinx/xc7a35t.bin /usr/share/nextpnr/xilinx-chipdb/
```
### replace above for xc7z020clg400-1 ###
```
$ cd nextpnr-xilinx
$ python3 xilinx/python/bbaexport.py --device xc7z020clg400-1 --bba xilinx/xc7z020clg400-1.bba
$ ./build/bba/bbasm --l xilinx/xc7z020clg400-1.bba xilinx/xc7z020clg400-1.bin
$ sudo mkdir -p /usr/share/nextpnr/xilinx-chipdb
$ sudo cp xilinx/xc7z020clg400-1.bin /usr/share/nextpnr/xilinx-chipdb/
```

### openFPGALoader ###
Remember to copy over udev rules
```
$ sudo cp 99-openfpgaloader.rules /etc/udev/rules.d/
# reload the rules
$ sudo udevadm control --reload-rules
$ sudo udevadm trigger
```







