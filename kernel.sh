export CROSS_COMPILE=~/Android/Toolchains/aarch64-elf/bin/aarch64-xxmustafacooTR-elf-
export CROSS_COMPILE_ARM32=~/Android/Toolchains/arm-eabi/bin/arm-xxmustafacooTR-eabi-
export CC=~/Android/Toolchains/clang/clang/bin/clang
export LDLLD=~/Android/Toolchains/clang/clang/bin/ld.lld
export ANDROID_MAJOR_VERSION=r
export ARCH=arm64
make clean
make mrproper
make nethunter_defconfig
make -j$(nproc --all)
