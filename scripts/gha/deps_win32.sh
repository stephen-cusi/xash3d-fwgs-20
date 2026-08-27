#!/bin/bash

. scripts/lib.sh

if [ "$GH_CPU_ARCH" = "arm64" ]; then
	# SDL2 official VC package doesn't include ARM64, build from source
	git clone --depth 1 --branch release-$SDL_VERSION https://github.com/libsdl-org/SDL.git SDL2_src
	cmake -S SDL2_src -B SDL2_build -G "Visual Studio 17 2022" -A ARM64 -DCMAKE_INSTALL_PREFIX=SDL2_arm64 -DSDL_SHARED=ON -DSDL_STATIC=ON -DSDL_TESTS=OFF -DSDL_EXAMPLES=OFF
	cmake --build SDL2_build --config Release
	cmake --install SDL2_build --config Release
	# Fix CMake multi-config install: copy lib/Release/ to lib/
	if [ -d "SDL2_arm64/lib/Release" ]; then
		cp -v SDL2_arm64/lib/Release/* SDL2_arm64/lib/
	fi
else
	curl -L "http://libsdl.org/release/SDL2-devel-$SDL_VERSION-VC.zip" -o SDL2.zip
	unzip -q SDL2.zip
	mv "SDL2-$SDL_VERSION" SDL2_VC
fi

if [ "$GH_CPU_ARCH" = "i386" ]; then
	rustup target add i686-pc-windows-msvc

	# YY-Thunks obj for Windows XP support
	curl -L "https://github.com/Chuyu-Team/YY-Thunks/releases/download/$YY_THUNKS_VERSION/YY-Thunks-Objs.zip" -o yy-thunks.zip
	unzip -q -j -o yy-thunks.zip 'objs/x86/YY_Thunks_for_WinXP.obj' -d 3rdparty/yy-thunks
	rm yy-thunks.zip
fi

curl -L https://github.com/FWGS/potential-meme/releases/download/prebuilts/mingw-w64-x86_64-pkgconf-1.2.3.0-1-any.pkg.tar.zst -o pkgconf.tar.zst
7z x pkgconf.tar.zst
7z x pkgconf.tar
rm pkgconf.tar*
mv mingw64 pkgconf

FFMPEG_ARCHIVE=$(get_ffmpeg_archive)
curl -L "https://github.com/FWGS/FFmpeg-Builds/releases/download/latest/$FFMPEG_ARCHIVE.zip" -o ffmpeg.zip
if [ -f ffmpeg.zip ]; then
	unzip -x ffmpeg.zip
	mv "$FFMPEG_ARCHIVE" ffmpeg
fi
