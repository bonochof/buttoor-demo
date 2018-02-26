class Door
  attr_reader :pos_x, :pos_y, :door_x
  
  def initialize( x, y )
    @flag = 0
    @pos_x = x
    @pos_y = y
    @door_x = 300
  end

  def setflag
    if @flag == 0 or @flag == 3 then
      @flag = 1
    else
      @flag = 3
    end
  end

  def close?
    return true if @flag == 0
    return false
  end

  def move?
    if @flag == 1 or @flag == 3 then
      return true
    else
      return false
    end
  end

  def slide( speed )
    if @flag == 1 then
      if @door_x > 100 then
        @door_x = @door_x - speed
      else
        @flag = 2
      end
    end
    else if @flag == 3 then
      if @door_x < 300 then
        @door_x = @door_x + speed
      else
        @flag = 0
      end
    end
  end
end
