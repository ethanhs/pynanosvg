# this is a work around to get NANOSVG_IMPLEMENTATION to be defined
cdef extern from 'defines.h':
    enum:
        NANOSVG_IMPLEMENTATION
        NANOSVGRAST_IMPLEMENTATION

cdef extern from 'nanosvg.h':

    enum NSVGpaintType:
        NSVG_PAINT_NONE
        NSVG_PAINT_COLOR
        NSVG_PAINT_LINEAR_GRADIENT
        NSVG_PAINT_RADIAL_GRADIENT

    enum NSVGspreadType:
        NSVG_SPREAD_PAD
        NSVG_SPREAD_REFLECT
        NSVG_SPREAD_REPEAT

    enum NSVGlineJoin:
        NSVG_JOIN_MITER
        NSVG_JOIN_ROUND
        NSVG_JOIN_BEVEL

    enum NSVGlineCap:
        NSVG_CAP_BUTT
        NSVG_CAP_ROUND
        NSVG_CAP_SQUARE

    enum NSVGfillRule:
        NSVG_FILLRULE_NONZERO
        NSVG_FILLRULE_EVENODD

    enum NSVGflags:
        NSVG_FLAGS_VISIBLE

    struct NSVGgradientStop:
        unsigned int color
        float offset

    struct NSVGgradient:
        float xform[6]
        char spread
        float fx
        float fy
        int nstops
        NSVGgradientStop stops[1]

    struct NSVGpaint:
        char type

    struct NSVGpath:
        float *pts
        int npts
        char closed
        float bounds[4]
        NSVGpath *next

    struct NSVGshape:
        char id[64]
        NSVGpaint fill
        NSVGpaint stroke
        float opacity
        float strokeWidth
        float strokeDashOffset
        float strokeDashArray[8]
        char strokeDashCount
        char strokeLineJoin
        char strokeLineCap
        char fillRule
        unsigned char flags
        float bounds[4]
        NSVGpath *paths
        NSVGshape *next

    struct NSVGimage:
        float width
        float height
        NSVGshape *shapes

    cdef NSVGimage *nsvgParseFromFile(const char *filename, const char *units, float dpi)

    cdef NSVGimage *nsvgParse(char *input, const char *units, float dpi)

    cdef void nsvgDelete(NSVGimage *image)


cdef extern from 'nanosvgrast.h':
    struct NSVGedge:
        pass

    struct NSVGpoint:
        pass

    struct NSVGactiveEdge:
        pass

    struct NSVGmemPage:
        pass

    struct NSVGrasterizer:
        float px, py
        float tessTol
        float distTol

        NSVGedge* edges
        int nedges
        int cedges

        NSVGpoint* points
        int npoints
        int cpoints

        NSVGpoint* points2
        int npoints2
        int cpoints2

        NSVGactiveEdge* freelist
        NSVGmemPage* pages
        NSVGmemPage* curpage

        unsigned char* scanline
        int cscanline

        unsigned char* bitmap
        int width, height, stride


    cdef NSVGrasterizer* nsvgCreateRasterizer()

    cdef void nsvgRasterize(NSVGrasterizer* r,
                   NSVGimage* image, float tx, float ty, float scale,
                   unsigned char* dst, int w, int h, int stride)

    cdef void nsvgDeleteRasterizer(NSVGrasterizer*)