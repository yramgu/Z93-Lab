@ECHO OFF

pushd %~dp0

REM Command file for Sphinx documentation

if "%SPHINXBUILD%" == "" (
	set SPHINXBUILD=sphinx-build
)
set SOURCEDIR=source
set BUILDDIR=build
set SPHINXPROJ=YourProject

%SPHINXBUILD% >NUL 2>NUL
if errorlevel 9009 (
	echo.
	echo.The 'sphinx-build' command was not found. Make sure you have Sphinx
	echo.installed, then set the SPHINXBUILD environment variable to point
	echo.to the full path of the 'sphinx-build' executable. Alternatively you
	echo.may add the Sphinx directory to PATH.
	echo.
	echo.If you don't have Sphinx installed, grab it from
	echo.http://sphinx-doc.org/
	exit /b 1
)

REM Just build changes
REM %SPHINXBUILD% -M html %SOURCEDIR% %BUILDDIR% %SPHINXOPTS%

REM Force a full rebuild
%SPHINXBUILD% -b html -a -w portalBuildWarning.txt %SOURCEDIR% %BUILDDIR%/html
goto end

:help
%SPHINXBUILD% -M help %SOURCEDIR% %BUILDDIR% %SPHINXOPTS%

:end
popd

xcopy /Y/E build\html\* \\shareduk\Projects\docs\HW-PLT_Website\your-location\

REM pause
