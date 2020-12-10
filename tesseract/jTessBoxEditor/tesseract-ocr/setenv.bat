::添加环境变量tesseract-ocr-ocr
@echo off
title 设置ocr相关环境变量

cd /d %~dp0

echo 查找tesseract是否存在，并设置
set tesseract=%cd%
wmic environment get name | find "tesseract"	
if "%errorlevel%"=="0" (
	echo 已存在环境变量tesseract
	wmic ENVIRONMENT  where "name='tesseract' and username='<system>'" set VariableValue="%tesseract%"
) else (
	echo 添加环境变量tesseract-ocr
	wmic ENVIRONMENT  create name="tesseract", username="<system>", VariableValue="%tesseract%"
)

echo.
echo 查找tessdata是否存在，并设置
set tessdata=%tesseract%\tessdata
wmic environment get name | find "tessdata"	
if "%errorlevel%"=="0" (
	echo 已存在环境变量tessdata
	wmic ENVIRONMENT  where "name='tessdata' and username='<system>'" set VariableValue="%tessdata%"
) else (
	echo 添加环境变量tessdata
	wmic ENVIRONMENT  create name="tessdata", username="<system>", VariableValue="%tessdata%"
)

echo.
echo 将tesseract添加到path
set path | find "tesseract"	
if "%errorlevel%"=="0" (
	echo 已存在
) else (		
	wmic ENVIRONMENT  where "name='path' and username='<system>'" set VariableValue="%path%;%%tesseract%%;"
)
pause>nul