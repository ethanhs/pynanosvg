from setuptools import setup, Extension
from Cython.Build import cythonize


ext = [Extension('svg', sources=['svg/__init__.pyx'],
                 include_dirs=['nanosvg/src/', 'pynanosvg/'])]

setup(
    name="pynanosvg",
    version="0.0.1",
    description="Wrapper around nanosvg",
    author="Ethan Smith",
    author_email="ethan@ethanhs.me",
    url="https://github.com/ethanhs/pynanosvg",
    license="MIT",
    ext_modules=cythonize(ext),
    packages=['svg_stubs'],
    package_data={'svg_stubs': ['py.typed', 'svg.pyi']}
)