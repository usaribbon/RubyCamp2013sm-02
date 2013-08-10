# エンディングシーンの管理用クラス
class Ending
  def initialize
    @image = Util.load_image("ending_bg.png")
  end

  def play
    if Input.keyPush?(K_SPACE)
      exit
    end
    Window.draw(0, 0, @image)
  end
end