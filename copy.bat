@echo ������Դ�ļ�

if not exist dist md dist
cd dist
if not exist res md res

cd ..
xcopy /y res dist\res