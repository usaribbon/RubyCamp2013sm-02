# ゲームオーバーシーンの管理用クラス
class Gameover
  def initialize
    @image = Util.load_image("game_over.png")
  end

  def play
    exit if Input.keyPush?(K_SPACE)
    Window.draw(0, 0, @image)
  end
end
