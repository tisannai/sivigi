# Sivigi

Sivigi is SVG (Standard Vector Graphics) drawing tool. The drawing is
created programmatically using Ruby language. Sivigi includes user
methods that are used to create the Figure and all the contained
Drawables.

NOTE 170204: Sivigi is going to be developed by using it. Backwards
compatibility will be broken every now and then if improvements
require it.


## Features

* Flexible position definitions
* Relative coordinates, references to other drawables
* Template based Drawables, duplicate templates
* Groups, i.e. manipulate Drawables as a group
* Layers, define the order of drawing (masking)
* Simple labeling for Boxes, Circles and Lines
* Drawables: Box, Line, Circle, Polyline
* Arrow heads for Lines


## Usage

Let's start with a simple example defining the Sivigi (drawing) file, "onebox.siv.rb":

    Figure.create do
        size 100, 100
    end
    
    Box.draw do
        label 'BOX', :c
        size 50, 30
        pos 50, 50
    end
    
Sivigi includes the Sivigi module by default, to enable short naming
for drawing components. `Figure.create` is used to define the frame
for the figure. It is also a clipping area, so Drawables should fit
into the area defined (100*100).

Then we simply draw box to the figure. We give it a label and place it
into the center of the box (":c"). Then we define the size and
position of the box, box center.

This is file is converted to an SVG figure (stdout) with:

    shell> sivigi -f onebox.siv.rb


## Syntax

### Property methods

Most Drawables are created with a Ruby block (See: previous
chapter). There might be multiple properties that the user sets, so a
block is convenient. However, for very simple drawables, an
alternative way can be used.

For example one might want to create a Line with arrow at the end:

    Line.spec( [150,150], [200,150] ).label( 'line1' ).earrow

Class method "Line.spec" creates a Line drawable with given
endpoints. Line starts from x=150,y=150 and ends to x=200,y=150,
i.e. it is a vertical line. This method, as well as all Property
methods, return the object itself, so additional method calls can be
chained (appended). In this case a label is given, and the line is
given an end arrow ("earrow").

If Property method is given without arguments, it returns the current
value of the Property.


### Dimensions and Coordinates

Box geometry is specified with position and size. Both are a pair of x
and y values. Position is coordinate based, and size is dimension
based. However they are in many ways the same, and in fact they are
both based on "Pos" class.

Pos class have two Coord properties which are either absolute or
relative coordinates. Coordinates grow to right for x and downwards
for y. Absolute coordinates are references to figure boundary, and
relative coordinates are references to some Drawable, which might
"change" its position.

We might for example want to draw two Boxes and a Line in
between. First we define two boxes:

    a = Box.draw.pos(  50, 20 ).size( 50, 10 )
    b = Box.draw.pos( 150, 20 ).size( 50, 10 )

Then we can refer to the left and right sides of the boxes and draw a
line in between.

   Line.spec( a.side(:r), b.side(:l) )

The line is between the right side of "a" and left side of "b". The
Drawables should be assigned to variables, in order to reference them
later.

Relative coordinates are not resolved until the actual output phase
starts. Output phase is after all Drawables has been defined,
i.e. after input file is processed.


### Duplication

A common paradigm for creating Drawables is to create a template and
then copy the template for a number of times. Each copy will, at
least, get a unique position after copying.

For example:

    base = Box.base do
      pos  100, 50
      size 100, 50
      linewidth 3
      fontsize 12
    end
    
    10.times do |i|
      base.dup.movey( (i+1)*80 )
    end

This would create a Box base. The Box base is not visible by itself,
however the duplicates are. Each duplicate is created in the loop and
moved downwards.


## Groups

Groups are used to create a collection of Drawables. We might for
example want to have a certain set of Drawables in fixed positions
relative to each other. However, as a group, we might want to relocate
them.

It this case, we should create a Group that includes the Drawables we
want to relocate.

Group example:

    g1 = Group.inside do
        ball = Circle.spec( [200-25, 100], 25 ).label( 'ball' )
        elli = Ellipse.spec( [120, 150], [50,25] )
    end

The ball and the ellipse now belong to the Group "g1". Their positions
are relative to g1 position, which is not even given yet.

We might move the Group:

    g1.move( 50, 50 )

Group can also be duplicated. It will create duplicate of all the
contained Drawables.


## Layers

Layers are used to define the drawing order. Layers are drawn in
order. If any, the later layers are drawn on top of earlier layers.
Later layer Drawables will overdraw the Drawables from the earlier
layers.

The first and default layer, is ":default". You can add layers on top:

    Layer.system.add :g1, :g2

This would add two layers to the layer list, and the layers would now
be (in the drawing order): :default, :g1, :g2.

Typically the layers are defined at the beginning of the drawing and
referred later. Each Drawable is placed to the layer that is currently
active. Layer can be activated by doing:

    Layer.system.use :g1

User can also attach a layer reference directly to the Group
definition:

    g1 = Group.inside( :g1 ) do
        ball = Circle.spec( [200-25, 100], 25 ).label( 'ball' )
        elli = Ellipse.spec( [120, 150], [50,25] )
    end

Content of this Group would use :g1 layer, and after the Group all
Drawables would use the previous layer again.


## Drawables

### 2D Drawables

#### Box and Frame

Box is defined by position and size. Additionally it can be given a
label. When Box is filled, it will cover other objects that have been
drawn earlier.

Box sides and corners can be references, in order to place other
Drawables to relative positions.

Frame is same as Box, but it is not filled. It will cover other
objects only with its boundary.


### Ellipse and Circle

Ellipse is defined by position and size. In can have the same
decorations as Box. Circle is a special case of Ellipse, and its size
definition is a scalar, i.e. the radius.


### 1D Drawables

#### Text

Text is a block of text which is placed to defined position. Its
characteristics are defined with font and fontsize. It can also be
rotated.


#### Line

Line is defined by end points. Additionally it can be decorated with
label and arrow endings.


#### Polyline

Polyline has multiple segment end points. It has the same decorations
as Line.


## Common properties

The are a number of common properties that all or almost all Drawables
share.

* Visible:    If Drawables is visible, it will be drawn.
* Layer:      Drawing order.
* Unit:       Drawing unit (default: mm).
* Linewidth:  Width of line.
* Font:       Used font for Label and Text.
* Fontsize:   Font size.
* Fillcolor:  Drawable filling color.
* Linecolor:  Drawable boundary color.


## Tests

Tests are in the "test" directory. They can be used as examples for
usage of different Sivigi features.
