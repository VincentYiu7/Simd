::@echo off

echo Try to estimate SVN revision:

set USER_VERSION=0.0.5
set SUBWCREV_EXE=SubWCRev.exe
set TRUNK_DIR=..\..
set SIMD_VERSION_FILE=%TRUNK_DIR%\src\Simd\SimdVersion.h
set VERSION_FILE=%TRUNK_DIR%\prj\cmd\Version.cmd

for %%X in (%SUBWCREV_EXE%) do (set SUBWCREV_EXE_FOUND=%%~$PATH:X)
if not defined SUBWCREV_EXE_FOUND (
echo Execution file "%SUBWCREV_EXE%" is not found!
exit 0
)

%SUBWCREV_EXE% %TRUNK_DIR%
if ERRORLEVEL 1 exit 0

if exist %VERSION_FILE% (
    call %VERSION_FILE%
) else (
	set VERSION=0
)
set LAST_VERSION=%VERSION%

echo set VERSION=%USER_VERSION%.$WCREV$>%VERSION_FILE%
%SUBWCREV_EXE% %TRUNK_DIR% %VERSION_FILE% %VERSION_FILE%
call %VERSION_FILE%

if not %LAST_VERSION% == %VERSION% set NEED_TO_UPDATE=1
if not exist %SIMD_VERSION_FILE% set NEED_TO_UPDATE=1

if not defined NEED_TO_UPDATE (
echo Skip updating of file "%SIMD_VERSION_FILE%" because there are not any changes.
goto END
)

echo Create or update file "%SIMD_VERSION_FILE%".

echo /*>%SIMD_VERSION_FILE%
echo * Simd Library.>>%SIMD_VERSION_FILE%
echo *>>%SIMD_VERSION_FILE%
echo * Copyright (c) 2011-2013 Yermalayeu Ihar.>>%SIMD_VERSION_FILE%
echo *>>%SIMD_VERSION_FILE%
echo * Permission is hereby granted, free of charge, to any person obtaining a copy>>%SIMD_VERSION_FILE% 
echo * of this software and associated documentation files (the "Software"), to deal>>%SIMD_VERSION_FILE%
echo * in the Software without restriction, including without limitation the rights>>%SIMD_VERSION_FILE%
echo * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell>>%SIMD_VERSION_FILE% 
echo * copies of the Software, and to permit persons to whom the Software is>>%SIMD_VERSION_FILE% 
echo * furnished to do so, subject to the following conditions:>>%SIMD_VERSION_FILE%
echo *>>%SIMD_VERSION_FILE%
echo * The above copyright notice and this permission notice shall be included in>>%SIMD_VERSION_FILE% 
echo * all copies or substantial portions of the Software.>>%SIMD_VERSION_FILE%
echo *>>%SIMD_VERSION_FILE%
echo * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR>>%SIMD_VERSION_FILE% 
echo * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,>>%SIMD_VERSION_FILE% 
echo * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE>>%SIMD_VERSION_FILE% 
echo * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER>>%SIMD_VERSION_FILE% 
echo * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,>>%SIMD_VERSION_FILE%
echo * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE>>%SIMD_VERSION_FILE%
echo * SOFTWARE.>>%SIMD_VERSION_FILE%
echo */>>%SIMD_VERSION_FILE%
echo.>>%SIMD_VERSION_FILE%
echo /*>>%SIMD_VERSION_FILE%                                                                                       
echo * File name   : SimdVersion.h>>%SIMD_VERSION_FILE%                                                       
echo * Description : This file contains information about current version.>>%SIMD_VERSION_FILE%               
echo *>>%SIMD_VERSION_FILE%                                  
echo * Do not change this file because the file is auto generated by script GetVersion.cmd.>>%SIMD_VERSION_FILE%
echo */>>%SIMD_VERSION_FILE%
echo.>>%SIMD_VERSION_FILE%
echo #ifndef __SimdVersion_h__>>%SIMD_VERSION_FILE%
echo #define __SimdVersion_h__>>%SIMD_VERSION_FILE%
echo.>>%SIMD_VERSION_FILE%
echo #define SIMD_VERSION "%VERSION%">>%SIMD_VERSION_FILE%
echo.>>%SIMD_VERSION_FILE%
echo #endif//__SimdVersion_h__>>%SIMD_VERSION_FILE%
echo.>>%SIMD_VERSION_FILE%

:END
