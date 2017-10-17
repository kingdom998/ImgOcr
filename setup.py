# coding: -utf8-

import os
import shutil
import py2exe
from glob import glob
from distutils.core import setup


data_files = [("buildlangs", glob("./buildlangs/*.*"))]

py2exe_options = {
    "dll_excludes": ["tesseract.exe", "MSVCP90.dll", "msvcr110.dll", "cairo.dll"],
    "includes": ["sip", "PyQt4.QtCore"]  # 如果打包文件中有PyQt代码，则这句为必须添加的
}

setup(
    console=[{"script": r"imgocr.py"}],
    data_files=data_files,
    requires=['PyQt4', 'xlrd', 'pytesseract'],
    options={"py2exe": py2exe_options}
)

# 拷贝 tessercat 程序和依赖库到 dist 目录
if not os.path.exists("dist"):
    os.mkdir("dist")

os.chdir("dist")
srcdir = os.getenv("tesseract")
distdir = "tesseract"
if os.path.exists(distdir):
    shutil.rmtree(distdir)
shutil.copytree(srcdir, distdir)
