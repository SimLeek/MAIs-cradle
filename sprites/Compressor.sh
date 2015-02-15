#!/bin/bash

pngquant *.png

for f in *.png; do 
	mv $f ${f/-fs8/}                    
done
