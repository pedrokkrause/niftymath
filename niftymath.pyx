from libc.math cimport frexp

def mul(iterable):
    """
    Multiplies every number of an iterable.
    1.2x faster than pure python implementation.
    """
    cdef double result = 1.0
    for item in iterable:
        result *= item
    return result

def ipow(double x, int n):
    """
    Calculates x to an integer power n.
    x3.4 faster than x**n if x is an int.
    x1.8 faster than x**n if x is float.
    """
    cdef double result = 1.0
    if n < 0:
        n = -n
        x = 1/x
    while n:
        if n&1:
            result *= x
        n >>= 1
        x *= x
    return result

def in_polygon(tuple point, tuple polygon):
    """
    Checks whether a point is inside a polygon.
    """
    cdef double px, py, p1x, p1y, p2x, p2y
    cdef int i
    cdef bint inside = False

    px, py = point

    for i in range(len(polygon)):
        p1x, p1y = polygon[i-1]
        p2x, p2y = polygon[i]

        if p1y == py:
            inside = not inside
        elif ((p1y < py < p2y) or (p1y > py > p2y)) and ((p2y > p1y) == ((p2x - p1x) * (py - p1y) > (px - p1x) * (p2y - p1y))):
            inside = not inside

    return inside

def ftan(double x):
    """
    Fast approximate tangent calculation for the range |x| < 1.782.
    Maximum 0.022% error in the valid range.
    Best for x near 0 or near ±pi/2.
    x1.9 faster than math.tan.
    """
    cdef double a = -0.071418746801430037932035310445275133023268463916017475056773701
    cdef double b = -0.002170119652387004347929489312373762801861458762800593265923564
    cdef double c = 0.4052847345693510857755178528389105556174350986889861953824361275

    cdef double x2 = x * x

    cdef double val = x * (1 + x2 * (a + b * x2)) / (1 - c * x2)

    return val

def fsin(double x):
    """
    Fast approximate sine calculation for the range |x| < 1.8.
    Maximum 0.0056% error in the valid range.
    Best for x near 0 or near ±pi/2.
    x1.9 faster than math.sin.
    """
    cdef double a = -0.0652006733492028659555038213199047526396286509
    cdef double b = 0.00159370362073639727783832883519640891402883102
    cdef double c = 0.1013211836423377714438794632097276389043587746722465488456090318

    cdef double x2 = x * x

    cdef double val = x * (1 + x2 * (a + b * x2)) * (1 - c * x2)

    return val

def fcos(double x):
    """
    Fast approximate cosine calculation for the range |x| < 1.793.
    Maximum 0.013% error in the valid range.
    Best for x near 0 or near ±pi/2.
    x1.9 faster than math.cos.
    """
    cdef double a = -0.0943722252251731605910587705015064820798017915
    cdef double b = 0.00299804390895191710433426883108066330392814892
    cdef double c = 0.4052847345693510857755178528389105556174350986889861953824361275

    cdef double x2 = x * x

    cdef double val = (1 + x2 * (a + b * x2)) * (1 - c * x2)

    return val

def flog2(double x):
    """
    A fast estimate of the base-2 logarithm of x.
    Maximum absolute error of 0.009.
    1.4x faster than math.log2.
    """
    cdef int exp
    cdef double m = frexp(x, &exp)
    cdef double e = <double>exp

    cdef double val = m * (-1.3476872 * m + 3.99014674) - 2.64915468 + e

    return val

