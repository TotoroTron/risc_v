#!/usr/bin/env bash
PROJECT_NAME=color_cycle
DB_DIR=/usr/share/nextpnr/prjxray-db
CHIPDB_DIR=/usr/share/nextpnr/xilinx-chipdb
DEVICE=xc7z020
PART=xc7z020clg400-1
FAMILY=zynq7
BOARD=arty_z7_20

set -ex
yosys -p "synth_xilinx -flatten -abc9 -nobram -arch xc7 -top top; write_json ${PROJECT_NAME}.json" ${PROJECT_NAME}.v
nextpnr-xilinx --chipdb ${CHIPDB_DIR}/${DEVICE}.bin --xdc ${BOARD}.xdc --json ${PROJECT_NAME}.json --write ${PROJECT_NAME}_routed.json --fasm ${PROJECT_NAME}.fasm
fasm2frames.py --part ${PART} --db-root ${DB_DIR}/${FAMILY} ${PROJECT_NAME}.fasm > ${PROJECT_NAME}.frames
xc7frames2bit --part_file ${DB_DIR}/${FAMILY}/${PART}/part.yaml --part_name ${PART} --frm_file ${PROJECT_NAME}.frames --output_file ${PROJECT_NAME}.bit

#To send to SRAM:
openFPGALoader --board ${BOARD} ${PROJECT_NAME}.bit

#To send to FLASH: 
# openFPGALoader --board ${BOARD} -f ${PROJECT_NAME}.bit
