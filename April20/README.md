# Messing with Example

For this week, we messed around with the in-class example and seeing what we can do to change it. I struggled to expand beyond it much. Though I eventually understood the code as was, I could not figure out how to import the gemomerative library to try it with a word, so I had to stay within the example itself and experiment with how different numbers and actions would change the product.


## Different Radius

I played around with the radius first, too see what that would look like. The pink lines are with a random(0,300), the magenta is (0,50), the white is (50,100), and the oragne is (10,80), the one I eventually settled on. For all of these, the number of Rotators was set to [200]. 

<img src="radius0300.jpg" width="400">   <img src="radius050.jpg" width="400">
<img src="radius50100.jpg" width="400">   <img src="radius1080.jpg" width="400">


## Circles instead

Then, I drew a version using ellipse/circles instead of lines, with no fill in them, so we could just see the outline (by changing the line() to ellipse() in the drawLine() function. It's a weird experience to see how the program reads the code intended for the lines drawn for circles. I can't/don't actually fully  understand it, but it does look cool. 

<img src="ellipse.jpg" width="400">

Here is a [video](https://youtu.be/KagKPBDxsd8) of this version.


## Speed, colors, and mouseClicked

I really enjoyed playing around and increasing the acceleration, but I wanted it to be prompted. So I made a new function for mousePressed() that speeds up the acceleration to .1 when the mouse is pressed, to make it a little more satisfying to play around with. I then also decided to make the colors change randomly when doing that by creating a stroke(random(255), random(255), random(255)) that makes almost a strobe effect.

Here is a [video](https://youtu.be/vhyeKGA_ibU) of the example.



