# niftymath
Handy optimized math functions

## Current functions

`mul`
Multiplies every number of an iterable.
1.2x faster than pure python implementation.

`ipow`
Calculates x to an integer power n.
x3.4 faster than x**n if x is an int.
x1.8 faster than x**n if x is a float.

`in_polygon`
Checks whether a point is inside a polygon.

`ftan`
Fast approximate tangent calculation for the range |x| < 1.782.
Maximum 0.022% error in the valid range.
Best for x near 0 or near ±pi/2.
x1.9 faster than math.tan.
