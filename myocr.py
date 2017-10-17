# -*- coding: utf-8 -*-


import os

from PIL import Image
from pytesseract import *

# 二值化
threshold = 100
table = []
for i in range(256):
    if i < threshold:
        table.append(0)
    else:
        table.append(1)


def ocr(url):
    img = Image.open(url)
    img.resize((800, 400))
    img = img.convert("L")
    img = img.point(table, '1')
    word = image_to_string(img, lang="fontyp", config="digits")

    return word[-4:] if len(word) >= 4 else word


# 遍历指定目录，显示目录下的所有文件名
def test(fdir="./res"):
    fout = open("out.txt", "w")
    names = os.listdir(fdir)
    names.sort()
    for name in names:
        url = os.path.join(r'%s\%s' % (fdir, name))
        fout.write(ocr(url) + "\n")
    fout.close()


if __name__ == '__main__':
    test()
