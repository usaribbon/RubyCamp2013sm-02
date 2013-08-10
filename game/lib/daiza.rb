class Daiza < Sprite
  def update
    dx = Input.x * 3
    self.x += dx
    unless (0..(Window.width - self.image.width)).include?(self.x)
      self.x -= dx
    end
  end
end
