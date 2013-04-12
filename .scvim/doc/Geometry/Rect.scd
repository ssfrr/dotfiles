Rect			rectangle

Class methods:

new(inLeft, inTop, inWidth, inHeight)

return a new Rect with the given upper left corner and dimensions.

newSides(inLeft, inTop, inRight, inBottom)

return a new Rect with the given boundaries.

fromPoints(inPoint1, inPoint2)

return a new Rect defined by the given Points.

Instance methods:

left
top
right
bottom

Get the value of the boundary.

left_(aValue)
top_(aValue)

Set the value of the boundary.

set(inLeft, inTop, inWidth, inHeight)

set the boundaries to the given values.

setExtent(inWidth, inHeight)

set the dimensions.

width

return the width.

height

return the height,

width_(aValue)

set the width.

height_(aValue)

set the height.

origin

return the upper left corner as a Point.

corner

return the lower right corner as a Point.

extent

return a Point whose x value is the height and whose y value is the width.

leftTop

return the upper left corner as a Point.

rightTop

return the upper right corner as a Point.

leftBottom

return the lower left corner as a Point.

rightBottom

return the lower right corner as a Point.

moveBy(x, y)

returns a new Rect which is offset by x and y.

moveTo(x, y)

returns a new Rect whose upper left corner is moved to (x, y).

moveToPoint(aPoint)

returns a new Rect whose upper left corner is moved to aPoint.

resizeBy(x, y)

returns a new Rect whose dimensions have been changed by (x, y).

resizeTo(x, y)

returns a new Rect whose dimensions are (x, y).

insetBy(x, y)

returns a new Rect whose boundaries have been inset by (x, y). If only one argument is supplied, it will be used for both x and y.

insetAll(insetLeft, insetTop, insetRight, insetBottom)

returns a new Rect whose boundaries have been inset by the given amounts.

contains(aPoint)

answers whether aPoint is in the receiver.

union(aRect)
| aRect

returns a new Rect which contains the receiver and aRect.

sect(aRect)
& aRect

returns a new Rect which is the intersection of the receiver and aRect.




