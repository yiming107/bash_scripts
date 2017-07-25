#!/bin/bash

# Modified on 25th July 2017 by Yiming Wang
# Credits to people's generous online sharing 

# define the version to install
version = "3.2.0"

# KEEP UBUNTU OR DEBIAN UP TO DATE
sudo apt-get -y autoremove ffmpeg x264 libx264-dev

#-y means yes for all prompts 

sudo apt-get update

# INSTALL THE DEPENDENCIES
echo "Installing related dependencies..."
echo "Installing build-related dependencies..."

# Build tools:
sudo apt-get install -y build-essential cmake pkg-config

sudo apt-get install -y libopencv-dev

echo "Installing GUI-related dependencies..."
# GUI
sudo apt-get install -y qt5-default libvtk6-dev libgtk2.0-dev

echo "Installing Media-related dependencies..."
# Media I/O:
echo "OpenCV" $version "ready to be used"
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev

echo "Installing Video-related dependencies..."
# Video I/O:
sudo apt-get install -y libfaac-dev libmp3lame-dev libdc1394-22-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev x264 v4l-utils libavcodec-dev libavformat-dev libswscale-dev libavresample-dev ffmpeg

echo "Installing Parallelism and linear algebra-related dependencies..."
# Parallelism and linear algebra libraries:
sudo apt-get install -y libtbb2 libtbb-dev libeigen3-dev

echo "Installing Python-related dependencies..."
# Python:
sudo apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy

echo "Installing Java-related dependencies..."
# Java:
sudo apt-get install -y ant default-jdk

echo "Installing Documentation-related dependencies..."
# Documentation:
sudo apt-get install -y doxygen

echo "Download the OpenCV source files ..."
cd ~
mkdir OpenCV
cd ~/OpenCV

wget https://github.com/opencv/opencv/archive/$version.zip
unzip $version.zip
rm $version.zip

cd ~/OpenCV
wget https://github.com/opencv/opencv_contrib/archive/$version.zip
unzip $version.zip
rm $version.zip

echo "Installing OpenCV now..."

cd ~/OpenCV/opencv-$version
mkdir build
cd build


sudo rm CMakeCache.txt
sudo cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D FORCE_VTK=ON -DBUILD_EXAMPLES=ON -D OPENCV_EXTRA_MODULES_PATH=~/OpenCV/opencv_contrib-$version/modules -D HAVE_FFMPEG=YES ..

make -j4 # adapt the number based on the core number

sudo make install

sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

sudo ldconfig

echo "OpenCV is installed with version::"

pkg-config --modversion opencv

