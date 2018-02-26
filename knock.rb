class Knock
  attr_reader :pos_x, :pos_y
  @@sound = Sound.new("data/sounds/knock.wav")
  @@image1 = Image.load("data/graphics/chime_1.png")
  @@image2 = Image.load("data/graphics/chime_2.png")
  @@image3 = Image.load("data/graphics/chime_3.png")
  @@image4 = Image.load("data/graphics/chime_4.png")
  @@image5 = Image.load("data/graphics/chime_5.png")
  @@image6 = Image.load("data/graphics/chime_6.png")
  @@image7 = Image.load("data/graphics/chime_7.png")
  @@image8 = Image.load("data/graphics/chime_8.png")

  def initialize( x, y )
    @pos_x = x
    @pos_y = y
    @sound_flag = 0
  end

  def setflag
    @@sound.play
    @time = Time.now
    @sound_flag = 1
    @image_pos = Array.new(8)
    @image_pos.length.times do |i|
      @image_pos[i] = rand(100)
    end
  end

  def play_now?
    return true if @sound_flag == 1
    return false
  end

  def chime(door_x,door_y)
    Window.draw_scale(door_x-@image_pos[0],door_y-@image_pos[7],@@image1,0.3,0.3,nil,nil,4)
    Window.draw_scale(door_x+@image_pos[1],door_y-@image_pos[6],@@image2,0.3,0.3,nil,nil,4)
    Window.draw_scale(door_x-@image_pos[2],door_y+@image_pos[5],@@image3,0.3,0.3,nil,nil,4)
    Window.draw_scale(door_x+@image_pos[3],door_y-@image_pos[4],@@image4,0.3,0.3,nil,nil,4)
    Window.draw_scale(door_x-@image_pos[4],door_y-@image_pos[3],@@image5,0.3,0.3,nil,nil,4)
    Window.draw_scale(door_x+@image_pos[5],door_y-@image_pos[2],@@image6,0.3,0.3,nil,nil,4)
    Window.draw_scale(door_x-@image_pos[6],door_y+@image_pos[1],@@image7,0.3,0.3,nil,nil,4)
    Window.draw_scale(door_x-@image_pos[7],door_y+@image_pos[0],@@image8,0.3,0.3,nil,nil,4)
    time2 = Time.now
    if time2 - @time > 1.3 then
      @sound_flag = 0
    end
  end
end