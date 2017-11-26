from svg import Parser, SVG


def test_parse_file():
    svg = Parser.parse_file('tests/Londonhackspacelogo.svg')
    assert isinstance(svg, SVG)


def test_parse_str():
    with open('tests/Londonhackspacelogo.svg') as s:
        svg = Parser.parse(s.read())
    assert isinstance(svg, SVG)
