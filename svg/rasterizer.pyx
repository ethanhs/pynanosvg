from nanosvg cimport (nsvgCreateRasterizer, nsvgRasterize,
                      nsvgDeleteRasterizer, NSVGrasterizer)


class SVGRasterizerError(Exception):
    pass


cdef class Rasterizer:
    """Cython class parsing and rendering SVG images."""
    cdef NSVGrasterizer* _nsvgrasterizer

    def __cinit__(self):
        self._nsvgrasterizer = nsvgCreateRasterizer()

    def __dealloc__(self):
        if self._nsvgrasterizer != NULL:
            nsvgDeleteRasterizer(self._nsvgrasterizer)

    def rasterize(self, svg: SVG, width: int, height: int, scale=1.0, tx=0, ty=0):
        """
        Rasterizes the SVG into a new buffer of bytes forming an RGBA image.
        """
        if svg._nsvgimage == NULL:
            raise ValueError('The given SVG is empty, you must parse the SVG first.')
        # used to calculate size of buffer
        length = width * height * 4
        stride = width * 4
        buff = bytes(length)
        nsvgRasterize(self._nsvgrasterizer,
                      svg._nsvgimage, tx, ty, scale,
                      buff, width, height, stride)
        return buff

    def rasterize_to_buffer(self, svg: SVG, width, height, scale=1.0, tx=0, ty=0, stride=0, buffer=None):
        """
        Rasterizes the SVG into a given buffer, which should be of length . Stride is usually w * 4.
        """
        if not isinstance(buffer, bytes):
            raise TypeError("`buffer` must be bytes, found {}".format(type(buffer)))
        if stride == 0:
            raise ValueError('You must set a stride to rasterize to a buffer, stride is 0')
        if svg._nsvgimage == NULL:
            raise ValueError('The given SVG is empty, you must parse the SVG first.')
        nsvgRasterize(self._nsvgrasterizer,
                      svg._nsvgimage, tx, ty, scale,
                      buffer, width, height, stride)
        return buffer
