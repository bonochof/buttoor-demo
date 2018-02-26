class Key
  attr_reader :mouse_x, :pos_x, :pos_y
  @@range1 = 1000
  @@range2 = 1300
  @@image = Image.load( 'data/graphics/fukidashi.png' )

  def initialize( x, y )
    @hold = false
    @sensor = false
    @pos_x = x
    @pos_y = y
  end

  def have
    @hold = !@hold
  end

  def hold?
    @hold
  end

  def inside?( x )
    return true if @@range1 < x && x < @@range2 && @hold
    return false
  end

  def draw( x )
    Window.draw_scale( @pos_x-50, @pos_y-200, @@image, 0.5, 0.5 );
    if self.inside?( x )
        Window.drawFont( @pos_x+150, @pos_y, "IN", Font.new(32), :color=>[50,0,0] )
    else
        Window.drawFont( @pos_x+150, @pos_y, "OUT", Font.new(32), :color=>[50,0,0] )
    end
  end
end