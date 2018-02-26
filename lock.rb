class Lock
  attr_reader :pos_x, :pos_y
  @@sound = Sound.new("data/sounds/key.wav")
  @@image = Image.load( 'data/graphics/lock.png' );
  
  def initialize( x, y )
    @lock = false
    @pos_x = x
    @pos_y = y
  end
  
  def lock
    @lock = !@lock
    @@sound.play
  end
  
  def lock?
    @lock
  end

  def draw( x, y )
    Window.draw_scale( x, y, @@image, 0.6, 0.6 ) if @lock
  end
end
