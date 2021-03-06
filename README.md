# pynanosvg

NOTE: nanosvg is no longer actively maintained

[![Travis](https://img.shields.io/travis/ethanhs/pynanosvg.svg?style=flat-square)](https://travis-ci.org/ethanhs/pynanosvg) | [![AppVeyor](https://img.shields.io/appveyor/ci/ethanhs/pynanosvg-9m0yu.svg?style=flat-square)](https://ci.appveyor.com/project/ethanhs/pynanosvg-9m0yu)

Pynanosvg is a wrapper around [nanosvg](https://github.com/memononen/nanosvg)
a simple svg parsing library. I created pynanosvg because the only other
options in Python were the librsvg bindings, which are very large!

# Install

Simple:
```
git clone --recursive https://github.com/ethanhs/pynanosvg.git
cd pynanosvg
python3 -m pip install .
```

or just

> python3 -m pip install pynanosvg

# Usage

The following parses an SVG file, rasterizes it, and saves it as a PNG

```python
# import things
from svg import Parser, Rasterizer, SVG
from PIL import Image  # for saving rasterized image
# Parse from a file
svg = Parser.parse_file('my_cool_img.svg')
print('Image is {} by {}.'.format(svg.width, svg.height))
rast = Rasterizer()
buff = rast.rasterize(svg, svg.width, svg.height)
im = Image.frombytes('RGBA', svg.width, svg.height, buff)
im.save('my_cool_img.png')  # save the converted image!
```
