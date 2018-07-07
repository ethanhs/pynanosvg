from setuptools import setup, Extension
from Cython.Build import cythonize
import os
from os import path
import sys

this_directory = path.abspath(path.dirname(__file__))
with open(path.join(this_directory, 'README.md')) as f:
    long_description = f.read()

ext = [Extension('svg', sources=['svg/__init__.pyx'],
                 include_dirs=['./nanosvg/src/', './pynanosvg/'])]

setup(
    name="pynanosvg",
    version="0.3.1",
    description="Wrapper around nanosvg",
    author="Ethan Smith",
    author_email="ethan@ethanhs.me",
    url="https://github.com/ethanhs/pynanosvg",
    license="MIT",
    ext_modules=cythonize(ext),
    packages=['svg-stubs'],
    package_data={'svg-stubs': ['svg.pyi']},
    long_description=long_description,
    long_description_content_type='text/markdown',
)