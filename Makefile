BUILD = ./build

##
# Simple build
#
all:
	python $(BUILD)/build.py

##
# Minified build
#
min:
	python $(BUILD)/build.py -m
