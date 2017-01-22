# sivigi

include Sivigi

Layer.system.add :g1, :g2


f = Sivigi::Figure.create do
    size 500, 500
end

base = Sivigi::Box.base do
    pos 0, 50
    size 100, 50
end

send = base.dup! do
    movex 100
    movey -10
    label "send", :c
end

recv = base.dup! do
    move 300, 0
    label "recv", :c
end

l4 = Line.spec( send.corner(:ur), recv.corner(:dl) ).earrow

ball = Circle.spec( [200-25, 100], 25 ).label( 'dii' )
elli = Ellipse.spec( [120, 150], [50,25] )

# Draw arrows.
Line.spec( send.path( recv ) ).earrow
Line.spec( send.path( ball ) ).earrow.label( "foo" )

Line.spec( [150,150], [200,150] ).label( 'dii' ).earrow

Line.spec( send.path( elli ) ).earrow.label( 'bar' )

Line.spec( elli.path( recv ) ).earrow.label( 'bar' )


g1 = Group.inside do
    ball = Circle.spec( [200-25, 100], 25 ).label( 'dii' )
    elli = Ellipse.spec( [120, 150], [50,25] )
end

g1.move( 50, 50 )

g2 = g1.dup
g2.move( 10, 10 )

g1.layer :g1
g2.layer :g2
