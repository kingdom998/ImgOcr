@echo off 
rem  langyp是本人定义的语言名称， fontyp是本人定义的字体名称，后续都会用到，可以修改成你喜欢的名字
rem set objname = langyp.fontyp.exp0
echo 请确认是否校验好box文件
pause

echo 1.生成font_properties
echo fontyp 0 0 0 0 0 >font_properties

echo 2.生成训练文件
tesseract langyp.fontyp.exp0.tif langyp.fontyp.exp0 -l eng -psm 7 nobatch box.train

echo 3.生成字符集文件
unicharset_extractor langyp.fontyp.exp0.box

echo 4.生成shape文件
shapeclustering -F font_properties -U unicharset -O langyp.unicharset langyp.fontyp.exp0.tr

echo 5.生成聚集字符特征文件
mftraining -F font_properties -U unicharset -O langyp.unicharset langyp.fontyp.exp0.tr

 echo 6.生成字符正常化特征文件
cntraining langyp.fontyp.exp0.tr

echo 7.更名
rename normproto fontyp.normproto 
rename inttemp fontyp.inttemp 
rename pffmtable fontyp.pffmtable 
rename unicharset fontyp.unicharset 
rename shapetable fontyp.shapetable
goto end
a、fontyp.traineddata文件最终要拷贝tesseract安装目录的tessdata目录下，才能被tesseract找到。
b、命令行最后必须带一个点。
c、执行结果中，1,3,4,5,13这几行必须有数值，才代表命令执行成功。
:end
echo 8.合并训练文件，生成fontyp.traineddata
combine_tessdata fontyp.

echo 执行完成请检查
pause