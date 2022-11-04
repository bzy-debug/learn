# Let's learn web canvas

I am using this book: [HTML Canvas Deep Dive: A Travelogue](https://joshondesign.com/p/books/canvasdeepdive/title.html)

## Chapter 1. Basic Drawing

It's important to understand that Canvas is for drawing pixels.
It doesn't have shapes or vectors. ==There are no objects to attach event handlers to==.
It just draws pixels to the screen.
As we shall see this is both a strength and a weakness. 

> There must be other ways to interact with canvas

Canvas only directly supports the rectangle shape.
To draw any other shape you must draw it yourself using a path.

The origin coordinate system is like below:

![coordinate system](./pics/coords.png)
