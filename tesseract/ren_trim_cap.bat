@echo off 
SETLOCAL ENABLEDELAYEDEXPANSION 
set name= 
FOR /F "tokens=*" %%i in ('dir /A-D /B /OD /TC') do ( 
     IF NOT "%%i"=="%~n0%~x0" ( 
         set name=%%i 
         set name=!name:~1! 
         ren "%%i" "!name!" 
     ) 
) 
ENDLOCAL 