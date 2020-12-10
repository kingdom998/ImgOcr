## 整个流程
* 1)、准备样本图片

手动刷新某网站验证码，手动或者写程序，保存了101个验证码样本文件，分别命名成：1.png，2.png，……，101.png。

该验证码有几个特点：a、定长4位，b、都是数字，c、有背景干扰，但比较简单，d、字体为红色。

为了提高识别率，首先做了一个工作就是灰度化处理，并全部转换成tif文件，分别命名成：1.tif，2.tif，……，101.tif，统一存放在d:\python\lnypcg下。
 
* 2)、合并样本图片

打开jtessboxeditor，点击Tools->Merge Tiff ，按住shift键选择前文提到的101个tif文件，并把生成的tif合并到新目录d:\python\lnypcg\new下，命名为langyp.fontyp.exp0.tif。

注意：langyp 是本人定义的语言名称，fontyp是本人定义的字体名称，后续都会用到，你可以修改成你喜欢的名字。
 
* 3)、生成box文件

执行命令生成langyp.fontyp.exp0.box文件

tesseract langyp.fontyp.exp0.tif langyp.fontyp.exp0 -l eng -psm 7 batch.nochop makebox
 
* 4)、修改box文件

切换到jTessBoxEditor工具的Box Editor页，点击open，打开前面的tiff文件langyp.fontyp.exp0.tif，工具会自动加载对应的box文件。

检查box数据，如下图所示，数字8被误认成字母H，手工修改H成8，并保存。

点击下图红色框的按钮，逐个核对tif文件的box数据，全部检查结束并保存。
 
* 5)、生成font_properties

执行echo命令生成font_properties。

echo fontyp 0 0 0 0 0 >font_properties

也可以手工新建一个名为font_properties的文本文件（注意该文件没有扩展名），内容为字体名fontyp，后面带5个0，分别代表字体的粗体、斜体等属性，这里全部是0

D:\python\lnypcg\new>echo fontyp 0 0 0 0 0 >font_properties

D:\python\lnypcg\new>type font_properties
fontyp 0 0 0 0 0
 
 
* 6)、生成训练文件

执行命令，生成langyp.fontyp.exp0.tr训练文件

tesseract langyp.fontyp.exp0.tif langyp.fontyp.exp0 -l eng -psm 7 nobatch box.train
 
* 7)、生成字符集文件

执行命令，生成名为unicharset的字符集文件。

unicharset_extractor langyp.fontyp.exp0.box 	
 
* 8)、生成shape文件

执行命令，生成shape文件

shapeclustering -F font_properties -U unicharset -O langyp.unicharset langyp.fontyp.exp0.tr
 
* 9)、生成聚集字符特征文件

执行命令，生成3个特征字符文件，unicharset、inttemp、pffmtable

mftraining -F font_properties -U unicharset -O langyp.unicharset langyp.fontyp.exp0.tr 
 
* 10)、生成字符正常化特征文件

执行命令，生成正常化特征文件normproto。

cntraining langyp.fontyp.exp0.tr
 
* 11)、更名

执行命令，把步骤9，步骤10生成的特征文件进行更名。

rename normproto fontyp.normproto
rename inttemp fontyp.inttemp
rename pffmtable fontyp.pffmtable 
rename unicharset fontyp.unicharset
rename shapetable fontyp.shapetable

 
* 12)、合并训练文件
执行命令，生成fontyp.traineddata文件。
combine_tessdata fontyp.
注意：
** a、fontyp.traineddata文件最终要拷贝tesseract安装目录的tessdata目录下，才能被tesseract找到。
** b、命令行最后必须带一个点。
**c、执行结果中，1,3,4,5,13这几行必须有数值，才代表命令执行成功。

 
## 简单版：
* 1、合并图片
* 2、生成box文件
tesseract langyp.fontyp.exp0.tif langyp.fontyp.exp0 -l eng -psm 7 batch.nochop makebox
* 3、修改box文件
* 4、生成font_properties
echo fontyp 0 0 0 0 0 >font_properties
* 5、生成训练文件
tesseract langyp.fontyp.exp0.tif langyp.fontyp.exp0 -l eng -psm 7 nobatch box.train
* 6、生成字符集文件
unicharset_extractor langyp.fontyp.exp0.box 
* 7、生成shape文件
shapeclustering -F font_properties -U unicharset -O langyp.unicharset langyp.fontyp.exp0.tr
* 8、生成聚集字符特征文件
mftraining -F font_properties -U unicharset -O langyp.unicharset langyp.fontyp.exp0.tr
* 9、生成字符正常化特征文件
cntraining langyp.fontyp.exp0.tr
* 10、更名
rename normproto fontyp.normproto
rename inttemp fontyp.inttemp
rename pffmtable fontyp.pffmtable 
rename unicharset fontyp.unicharset
rename shapetable fontyp.shapetable
* 11、合并训练文件，生成fontyp.traineddata
combine_tessdata fontyp.
