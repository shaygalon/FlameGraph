#!/bin/sh
FOLDER="/var/www/logs/perf"
RES=$FOLDER/core20-`date +%s`.svg
sudo perf record -F 99 -a -C 20 -g -- sleep $1
sudo taskset -c 40 perf script | ./stackcollapse-perf.pl --kernel > perf.folded
sudo taskset -c 40 ./flamegraph.pl --color=java --hash perf.folded > $RES
sudo chmod a+wr $RES
sudo chmod a+wr perf.folded perf.data

