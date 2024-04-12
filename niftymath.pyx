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
    x1.8 faster than x**n if x is a float.
    """
    cdef double result = 1.0
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
    cdef double x4 = x2 * x2

    cdef double val = x * (1 + a * x2 + b * x4) / (1 - c * x2)

    return val
