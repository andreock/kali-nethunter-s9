#!/bin/bash
export CROSS_COMPILE=/home/$USER/Android/Toolchains/aarch64-elf/bin/aarch64-elf-
export CROSS_COMPILE_ARM32=/home/$USER/Android/Toolchains/arm-eabi/bin/arm-eabi-
export CC=/home/$USER/Android/Toolchains/clang/bin/clang
export LDLLD=/home/$USER/Android/Toolchains/clang/bin/ld.lld

ZIP_DIR="/home/$USER/Android/Kernel/Zip/"
ZIP_ALT_DIR="/home/$USER/Android/Kernel/Zip_Alt/"
CUR_DIR=$PWD

export ANDROID_MAJOR_VERSION=r
export ARCH=arm64

function clean {
		printf "Cleaning\n"
		cd $CUR_DIR
		rm -rf drivers/gator_5.27/gator_src_md5.h scripts/dtbtool_exynos/dtbtool arch/arm64/boot/dtb.img arch/arm64/boot/dts/exynos/*dtb*
		make -j$(nproc) clean
		make -j$(nproc) mrproper
}

all="false"
clean="false"

if [ -d $ZIP_ALT_DIR ] 
then
    printf "Alternative Zip Exists\n" 
fi

if [ ! -d $ZIP_DIR ] 
then
    printf "Zip Folder DOESN'T Exists." 
fi

while getopts ":ca" flag; do
  case "${flag}" in
	c) clean='true' ;;
    a) all='true' ;;
  esac
done

if $clean
then
	clean
	exit 1
fi

if $all
then
	printf "Build Started\n"
	clean
	printf "Building G960\n"
	make exynos9810-starlte_defconfig
	make -j$(nproc --all)
	cp -vr $CUR_DIR/arch/arm64/boot/Image $ZIP_DIR/Kernel/G960zImage
	cp -vr $CUR_DIR/arch/arm64/boot/dtb.img $ZIP_DIR/Kernel/G960dtb.img

if [ -d $ZIP_ALT_DIR ] 
then
    printf "Building G960 Alternative\n"
	make exynos9810-starlte_defconfig
	sed -i 's/CONFIG_SECURITY_SELINUX_NEVER_ENFORCE=y/# CONFIG_SECURITY_SELINUX_NEVER_ENFORCE is not set/g' "$CUR_DIR"/.config
	make -j$(nproc --all)
	cp -vr $CUR_DIR/arch/arm64/boot/Image $ZIP_ALT_DIR/Kernel/G960zImage
	cp -vr $CUR_DIR/arch/arm64/boot/dtb.img $ZIP_ALT_DIR/Kernel/G960dtb.img
fi
	
	clean
	printf "Building N960\n"
	make exynos9810-crownlte_defconfig
	make -j$(nproc --all)
	cp -vr $CUR_DIR/arch/arm64/boot/Image $ZIP_DIR/Kernel/N960zImage
	cp -vr $CUR_DIR/arch/arm64/boot/dtb.img $ZIP_DIR/Kernel/N960dtb.img
	
if [ -d $ZIP_ALT_DIR ] 
then
    printf "Building N960 Alternative\n"
	make exynos9810-crownlte_defconfig
	sed -i 's/CONFIG_SECURITY_SELINUX_NEVER_ENFORCE=y/# CONFIG_SECURITY_SELINUX_NEVER_ENFORCE is not set/g' "$CUR_DIR"/.config
	make -j$(nproc --all)
	cp -vr $CUR_DIR/arch/arm64/boot/Image $ZIP_ALT_DIR/Kernel/N960zImage
	cp -vr $CUR_DIR/arch/arm64/boot/dtb.img $ZIP_ALT_DIR/Kernel/N960dtb.img
fi
	
	clean
fi
printf "Building G965\n"
make exynos9810-star2lte_defconfig
make -j$(nproc --all)
cp -vr $CUR_DIR/arch/arm64/boot/Image $ZIP_DIR/Kernel/G965zImage
cp -vr $CUR_DIR/arch/arm64/boot/dtb.img $ZIP_DIR/Kernel/G965dtb.img

if [ -d $ZIP_ALT_DIR ] 
then
printf "Building G965 Alternative\n"
make exynos9810-star2lte_defconfig
sed -i 's/CONFIG_SECURITY_SELINUX_NEVER_ENFORCE=y/# CONFIG_SECURITY_SELINUX_NEVER_ENFORCE is not set/g' "$CUR_DIR"/.config
make -j$(nproc --all)
cp -vr $CUR_DIR/arch/arm64/boot/Image $ZIP_ALT_DIR/Kernel/G965zImage
cp -vr $CUR_DIR/arch/arm64/boot/dtb.img $ZIP_ALT_DIR/Kernel/G965dtb.img
fi