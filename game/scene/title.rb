# タイトル（オープニング）シーンの管理用クラス
class Title
  def initialize
    @image = Util.load_image("title_bg.png")
  end

  def play
    if Input.keyPush?(K_SPACE)
      Director.change_scene(:game1)
    end
    Window.draw(0, 0, @image)
  end
end
