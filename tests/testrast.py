from svg import Parser, Rasterizer
from PIL import Image


def test_rast_to_bytes():
    svg = Parser.parse_file('tests/Londonhackspacelogo.svg')
    r = Rasterizer()
    buff = r.rasterize(svg, svg.width, svg.height)
    assert isinstance(buff, bytes)
    img = Image.open('tests/Londonhackspacelogo.png')
    assert buff == img.tobytes()