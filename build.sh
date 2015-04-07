#!/bin/bash

ipython nbconvert --to markdown yaml-structured-data.ipynb
mv -f yaml-structured-data.md README.md
ipython nbconvert --to slides --post serve yaml-structured-data.ipynb

