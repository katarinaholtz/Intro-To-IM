# Computer Art: Nested Squares

*Inspiration drawn from [Random Squares by William Kolomyjec](http://recodeproject.com/artwork/v2n3random-squares), in Computer Graphics and Art (1977)*
![](RandomSquares.jpg.png)


## End Result

![](NestedSquares.jpg)

The dynamic final piece included color:
![](NestedSquaresColor.jpg)


## Coding Process

Using nested for loops greatly simplified the code because it allowed for 1) a loop which created the nested squares, 2) a loop which repeated it across a row, and 3) a loop that repeated the row four more times to fill up the screen. I can't take all the credit, I had help that looked at my copy-pasting the nested squares and translating each time (5x5 for a total of 25 squares and 24 copy-pastes) and suggested using nested for loops. (Thank you, @Mark!)

Certain elements of creating the boxes were random, as in the original piece, such as the number (iterations) of nested squares, the offset between them, and the color. Figuring out the offset was crucial, because otherwise (I think) the offset became too much and caused the later nested squares to leave the zone it was supposed to be in and overlap with other sections. Adding -0.5 to the end seemed to fix it?

A section that I got a little stuck on was getting the nested squares to not simply nest into each other going towards the center like a pyramid, but have that slanted, off-center look. I ended up creating variables newPositionX and newPositionY that would randomly add to the offset position (which created the starting points for nested squares). That worked, and then it was just a matter of playing with the offset on the random number to make sure they would tilt to the left and up, instead of just down and to the right. random(5)-2 ended up working well. 

For the final piece I added some pizzazz by having it in color (randomly generated RBG values for each squares), with the option of adding a gradient within the nested box if desired. Each time the mouse is clicked, the drawing resets with new colors and new boxes - [here is a video](https://youtu.be/5EXfRUWTA1s) of what that looks like.

![](NestedSquaresGradient.jpg)

The only other thing I don't understand is why I still need a void draw() after the void MouseClicked(), or if there is a way to connect the two rather than having them as separate functions. 

