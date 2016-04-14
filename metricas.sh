#!/bin/bash

n_archivos=$(ls $1 | wc -l)
ls -1 $1 > nombres.txt

ls Metricas$1 &> basura.txt || mkdir Metricas$1
rm basura.txt

x=1
while [ $x -le $n_archivos ]
do
  archivo=$(awk NR==$x nombres.txt)
  nombre="${archivo%.*}"
  ffmpeg -loglevel panic -i $1$archivo -pr_metrics true $nombre.lhe 2>Metricas$1/metricas$nombre.txt
  let x=x+1
done
rm nombres.txt
