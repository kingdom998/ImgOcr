::��ӻ�������tesseract-ocr-ocr
@echo off
title ����ocr��ػ�������

cd /d %~dp0

echo ����tesseract�Ƿ���ڣ�������
set tesseract=%cd%
wmic environment get name | find "tesseract"	
if "%errorlevel%"=="0" (
	echo �Ѵ��ڻ�������tesseract
	wmic ENVIRONMENT  where "name='tesseract' and username='<system>'" set VariableValue="%tesseract%"
) else (
	echo ��ӻ�������tesseract-ocr
	wmic ENVIRONMENT  create name="tesseract", username="<system>", VariableValue="%tesseract%"
)

echo.
echo ����tessdata�Ƿ���ڣ�������
set tessdata=%tesseract%\tessdata
wmic environment get name | find "tessdata"	
if "%errorlevel%"=="0" (
	echo �Ѵ��ڻ�������tessdata
	wmic ENVIRONMENT  where "name='tessdata' and username='<system>'" set VariableValue="%tessdata%"
) else (
	echo ��ӻ�������tessdata
	wmic ENVIRONMENT  create name="tessdata", username="<system>", VariableValue="%tessdata%"
)

echo.
echo ��tesseract��ӵ�path
set path | find "tesseract"	
if "%errorlevel%"=="0" (
	echo �Ѵ���
) else (		
	wmic ENVIRONMENT  where "name='path' and username='<system>'" set VariableValue="%path%;%%tesseract%%;"
)
pause>nul