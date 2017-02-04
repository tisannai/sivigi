# -*- ruby -*- (sivigi)

f = Figure.create do
    size 500, 500
end

b1 = Box.draw do
    pos 100, 100
    size 100, 50

    label "Foobar", :c

    fillcolor 0x808080
end

b2 = Box.draw do
    size 100, 50
    pos b1.pos.dup.ox( 40 )
    label %w{OffsetBox lskjdflkaj sdflksda jlfkjsadlkfj}, :ur
end

b3 = b1.dup
b3.move( :r, 300 ).label( 'Just a Copy' )
b3.linecolor :red

b4 = b2.dup
b4.move( 200, 100 ).label( 'Just a Dup' )

l1 = Line.spec [20, 20], [30, 20]
l2 = Line.dir [40,40], :r, 50
l2.earrow
l2.label "diiduu", :u
l2b = Line.dir [40,32], :r, 50
l2b.sarrow
l3 = Line.dir [40,40], :d, 50
l3.arrow

l4 = Line.spec( b1.sidepos(:r, [3,5]), b2.side(:l) ).earrow

l5 = Line.dir( [50,50], :r, 150 ).earrow.label( "Diiduu", :u )
l5.linestyle :default

l6 = Line.dir( [50,150], :d, 150 ).earrow.label( "Fiifuu", :u )


t = Text.spec [30, 30], "Foobar", 12

e = Ellipse.draw do
    pos 75, 175
    size 50, 25
    label 'ellipse'
end

e.linestyle :dotted

c = Circle.draw do
    pos 100, 180
    radius 30
    label 'circle'
    linewidth 2
    linecolor "#aabb55"
    fillcolor "#55bbaa"
end
c.linestyle :spaced

pl1 = Polyline.spec( 100, 110, 140, 110, 100, 200 ).arrow

pl2 = pl1.dup
pl2.move( 10, 10 )

pl3 = pl2.dup.move( :r, 100 )

d = Dot.spec [10, 200]
