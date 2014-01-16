#!/bin/bash

dir=~/projects/resumeanalysis/app.py

source /usr/local/bin/virtualenvwrapper.sh
workon env2

cd $dir
python app.py
