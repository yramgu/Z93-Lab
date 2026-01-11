rem This will copy the html build to the published location
rem Kept as a separate script to let users experiment without taking
rem down released version. Should be run once happy with latest build
rem Keith 13th June 2019

xcopy /Y/E build\html\* \\shareduk\Projects\docs\your_location\

rem pause