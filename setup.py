from setuptools import setup, Extension
from Cython.Build import cythonize
import os
import sys


if sys.version_info < (3, 5) and os.name == 'nt':
    print("Nanosvg cannot be built on Python 3.4 or below on Windows.")
    sys.exit(1)

ext = [Extension('svg', sources=['svg/__init__.pyx'],
                 include_dirs=['nanosvg/src/', 'pynanosvg/'])]

setup(
    name="pynanosvg",
    version="0.1.1",
    description="Wrapper around nanosvg",
    author="Ethan Smith",
    author_email="ethan@ethanhs.me",
    url="https://github.com/ethanhs/pynanosvg",
    license="MIT",
    ext_modules=cythonize(ext),
    packages=['svg-stubs'],
    package_data={'svg-stubs': ['svg.pyi']}
)