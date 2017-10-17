@echo 复制资源文件

if not exist dist md dist
cd dist
if not exist res md res

cd ..
xcopy /y res dist\res