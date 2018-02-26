=begin
  ���C���t�@�C��
=end

# �e��t�@�C���ǂݍ���
require 'dxruby'
require_relative 'door'
require_relative 'knock'
require_relative 'lock'
require_relative 'key'

# �E�B���h�E�����ݒ�
Window.caption = "DoorKey"
Window.width   = 1600
Window.height  = 900

# �萔
$GROUND = 600
$BUTTON_SIZE = 100
$DOOR_SIZE_Y = 300
$MAN_SIZE_X = 100
$MAN_SIZE_Y = 200

# �e�@�\�N���X������
door = Door.new( 600+$BUTTON_SIZE*1, $GROUND-$BUTTON_SIZE )
knock = Knock.new( 600+$BUTTON_SIZE*3, $GROUND-$BUTTON_SIZE )
lock = Lock.new( 600+$BUTTON_SIZE*5, $GROUND-$BUTTON_SIZE )
key = Key.new( 600+$BUTTON_SIZE*7, $GROUND-$BUTTON_SIZE )

# �摜��񏉊���
image_back = Image.load( 'data/graphics/back.jpg' )
image_man1 = Image.load( 'data/graphics/man_standing.png' )
image_man2= Image.load( 'data/graphics/man_walking.png' )
image_door = Image.load( 'data/graphics/door.png' )
image_key = Image.load( 'data/graphics/key.png' )
image_button = Image.load( 'data/graphics/button.png' )

# �ϐ�
mouse_x = 0
speed = 2
dst = 0

Window.loop do
  # �w�i
  Window.draw( 0, 0, image_back )
  
  # �}�E�X�̓��͍X�V
  mouse_hist = mouse_x
  mouse_x = Input.mouse_x
  dst = -1 if mouse_hist > mouse_x
  dst = 1 if mouse_hist < mouse_x
  dst = 0 if mouse_hist == mouse_x
  
  # �}�E�X���N���b�N���ꂽ�ꍇ
  if Input.mouse_push?( M_LBUTTON )
    door.setflag if door.pos_x < mouse_x && mouse_x < door.pos_x + $BUTTON_SIZE && !lock.lock?
    knock.setflag if knock.pos_x < mouse_x && mouse_x < knock.pos_x + $BUTTON_SIZE && !door.move?
    lock.lock if lock.pos_x < mouse_x && mouse_x < lock.pos_x + $BUTTON_SIZE && key.hold? && door.close?
  end
  
  # ���̕ێ�
  if Input.key_push?( K_K )
    key.have
  end
  
  # �h�A����
  if door.move?
    door.slide( speed )
  end
  
  # �`�揇����
  if door.close?
    man_z = 2
    door_z = 0
  else
    man_z = 0
    door_z = 2
  end
  
  # �`��
  Window.draw_scale( door.pos_x, door.pos_y, image_button, 0.5, 0.5 )
  Window.drawFont( door.pos_x+180, door.pos_y+100, "Door", Font.new(32), :color=>[0,0,0] )
  Window.draw_scale( knock.pos_x, knock.pos_y, image_button, 0.5, 0.5 )
  Window.drawFont( knock.pos_x+180, knock.pos_y+100, "Knock", Font.new(32), :color=>[0,0,0] )
  Window.draw_scale( lock.pos_x, lock.pos_y, image_button, 0.5, 0.5 )
  Window.drawFont( lock.pos_x+180, lock.pos_y+100, "Lock", Font.new(32), :color=>[0,0,0] )
  key.draw( mouse_x ) # �Z���T�l�\��
  Window.draw_scale( mouse_x-$MAN_SIZE_X/2-70, $GROUND-$MAN_SIZE_Y-320, image_man1, 0.7, 0.7, nil, nil, man_z ) if dst == 0 # �l�ԕ\��
  Window.draw_scale( mouse_x-$MAN_SIZE_X/2-70, $GROUND-$MAN_SIZE_Y-320, image_man2, dst*0.7, 0.7, nil, nil, man_z ) if dst != 0 # �l�ԕ\��
  Window.draw_ex( mouse_x-100, $GROUND-$MAN_SIZE_Y-$MAN_SIZE_Y/2-100, image_key, :angle=>45, :scalex=>0.2, :scaley=>0.2, :z=>man_z+1 ) if key.hold? # �ێ����\��
  Window.draw( door.door_x, $GROUND-$DOOR_SIZE_Y-150, image_door, door_z ) # �h�A�\��
  lock.draw( door.door_x-160, $GROUND-$DOOR_SIZE_Y-200 )
  knock.chime(100, $GROUND-$DOOR_SIZE_Y-200) if knock.play_now? # �`���C��
  
  # �I��
  break if Input.keyPush?( K_ESCAPE )
end
