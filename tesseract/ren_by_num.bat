@echo off
setlocal enabledelayedexpansion

set  num=500
for /f "delims=" %%i in ('dir /b *.*') do ( 
if not "%%~ni"=="%~n0" ( 
	ren "%%i" "!num!.jpg" 
	set /A num+=1
	) 
)