from svg import SVG, Parser

def test_svg_size():
    svg = Parser.parse_file('tests/Londonhackspacelogo.svg')
    assert svg.width == 114
    assert svg.height == 114
    assert isinstance(svg.width, int)
    assert isinstance(svg.height, int)
