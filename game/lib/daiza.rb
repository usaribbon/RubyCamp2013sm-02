class Daiza < Sprite
  attr_reader :direction,:rimage

  def initialize(x, y, image)
    super
    @rimage = Util.load_image("rdaiza.png")
    @rimage.setColorKey([255,255,255])
    @nimage = self.image
    @direction = :up
  end

  def update
    dx = Input.x * 3
    self.x += dx
    unless (275..(Window.width - 76)).include?(self.x)
      self.x -= dx
    end
    if Input.keyPush?(K_UP)
      @direction = :down
      self.y = 0
      self.image = @rimage
    end
    if Input.keyPush?(K_DOWN)
      @direction = :up
      self.y = 500
      self.image = @nimage
    end
  end
end