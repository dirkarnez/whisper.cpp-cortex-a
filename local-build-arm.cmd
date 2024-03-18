@REM run as Administrator
@echo off
cd /d %~dp0
set DOWNLOADS_DIR=%USERPROFILE%\Downloads
set DOWNLOADS_DIR_LINUX=%DOWNLOADS_DIR:\=/%

SET PATH=^
%DOWNLOADS_DIR%\PortableGit\bin;^
%DOWNLOADS_DIR%\en.st-stm32cubeide_1.14.1_20064_20240111_1413_x86_64.exe\STM32CubeIDE\plugins\com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.11.3.rel1.win32_1.1.100.202309141235\tools\bin;^
%DOWNLOADS_DIR%\cmake-3.26.1-windows-x86_64\bin;

@REM set PATH=^
@REM D:\Softwares\x86_64-8.1.0-release-posix-seh-rt_v6-rev0\mingw64;^
@REM D:\Softwares\x86_64-8.1.0-release-posix-seh-rt_v6-rev0\mingw64\bin;^
@REM D:\Softwares\cmake-3.23.0-rc1-windows-x86_64\bin;


if exist cmake-build rmdir /s /q cmake-build

cmake.exe -G"MinGW Makefiles" ^
-DCMAKE_TOOLCHAIN_FILE=cubeide-gcc.cmake ^
-DCMAKE_MAKE_PROGRAM="%DOWNLOADS_DIR%/en.st-stm32cubeide_1.14.1_20064_20240111_1413_x86_64.exe/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.externaltools.make.win32_2.1.101.202401061624/tools/bin/make.exe" ^
-DCMAKE_BUILD_TYPE=Release ^
-DBUILD_SHARED_LIBS=OFF ^
-DWHISPER_BUILD_EXAMPLES=OFF ^
-DWHISPER_BUILD_TESTS=OFF ^
-DWHISPER_NO_AVX=ON ^
-DWHISPER_NO_AVX2=ON ^
-DWHISPER_NO_FMA=ON ^
-DWHISPER_NO_F16C=ON ^
-DCMAKE_BUILD_TYPE=Debug ^
-DCMAKE_INSTALL_PREFIX="cmake-build/${{ env.cmakeInstallationPath }}" -B./cmake-build &&^
cd cmake-build && ( cmake --build . --config Release && cmake --install . && echo Successful build || type .\CMakeFiles\CMakeError.log )  &&^
cd .. &&^
pause