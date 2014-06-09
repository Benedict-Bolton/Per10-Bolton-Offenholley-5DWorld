Per10-Bolton-Offenholley-5DWorld
================================

Not a 5D world, most certainly not. In fact more of a 3D world editor 
where one uses a GUI to control the Polyhedra to be made and places them
with mouseclicks.

Main File to Open in Processing:
  sketch_3DTutor
  
  
Movement through World:
  W == Forward
  S == Back
  
  A == Strafe Left
  D == Strafe Right
  
  Z == Move Up
  X == Move Down
  
  E == Rotate World Clockwise (Can throw off the Math of Polygon Placement and Collision)
  Q == Rotate World CountClockwise (")
  
  Mouse -- Change Point of View (i.e. turn head to look around)
  
  
Make/Place a Polyhedra:
  The GUI on the left side of the screen provides the user the area to input the desired specifications for
  the Polyhedra they wish to create. (Be sure to press enter after you have typed in fill and stroke values)
  
  To place the polyhedra click on the window on the right side of the screen. The Polyhedra will appear in 
  roughly the center of this window
  

Authors:
  
  Benedict Bolton -- (GUI, Polyhedra generation and collision)
  
  Corrin Offenholley -- (Camera, Saving and Loading created worlds to textfiles)
  
  
  
Known Bugs and Issues:

  -- Collision detection mathematics do always not work as intended and will allow you to phase through some parts of
some polyhedra

  -- Saving and Loading worlds to/from textfiles is non-functional despite textfield presence on the GUI. Issue presently
being with copying data from txt file to a string and then back into storage ArrayList that is used in the World.

  -- As of now does not seem possible in processing to simply create any-number-sided regular polygon in 3D, you must make
a series of triangles/quad_strips and overlap them to fill the desired shape.

  -- Was not able to enable camera rotation in full 360 degrees (ie such as a human turning around in a circle). Only 
able to enable different view points in same direction (ie like a human moving their head without turning their feet).
Temp fix is to rotate the world when the user wishes to turn, this shows all angles of the polygons but does interfere
and disrupt the Math which is used for shape placement and collision detection

  -- Movement blocking failed to prevent collision/camera-polyhedra overlap so presently movement reversals are being used
to handle collisions, which force the camera back many pixels from the polyhedra it would have collided with. Due to
occasional failings in the Math used for detection of collision this does not always result in the camera returning to the
correct location after collision.
