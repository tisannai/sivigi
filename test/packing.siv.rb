# sivigi

include Sivigi

f = Sivigi::Figure.create do
    size 500, 2500
    scale 25
end


x = 100
y = 20
xsize = 200
ysize = 150

group = Group.create do
    pos x, y
    pack :d
end

base = Box.base do
    size( xsize, ysize )
    fontsize 14
end
    

stack = base.dup.label( 'stack', :c ).pack
empty = base.dup.pack
heap  = base.dup.label( 'heap', :c ).pack
bss   = base.dup.label( 'bss', :c ).size( xsize, ysize-50 ).pack
text  = base.dup.label( 'text', :c ).size( xsize, ysize-50 ).pack

left = Line.spec( stack.side(:l), text.side(:l) )
right = Line.spec( stack.side(:r), text.side(:r) )

Line.dir( stack.side(:d), :d, 50 ).earrow
Line.dir( heap.side(:u), :u, 50 ).earrow
