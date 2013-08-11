require_relative 'lib/daiza'
require_relative 'lib/stage'
require_relative 'lib/bullet'
require_relative 'lib/CDTimer'
require_relative 'lib/BulletSelector'
require_relative 'lib/util'
require_relative 'lib/readyimg'

require_relative 'scene/title'
require_relative 'scene/game'
require_relative 'scene/ending'
require_relative 'scene/gameover'

# ゲーム進行管理用クラス
class Director
  # 初期化処理
  def initialize
    # ゲームを構成する各シーンの管理オブジェクトを生成
    @@scenes = {}
    @@scenes[:title]  = Title.new
    @@scenes[:game1]   = Game.new(1)#しまねっこ
    @@scenes[:game2]   = Game.new(2)#ルビー
    @@scenes[:game3]   = Game.new(3)#勾玉
    @@scenes[:ending] = Ending.new
    @@scenes[:gameover] = Gameover.new
    @@current_scene = :title
  end

  # シーン進行メソッド
  def play
    # 現在設定されているシーン管理オブジェクトのplayメソッドへ
    # 処理を委譲する
    @@scenes[@@current_scene].play
  end

  # シーン切り替え用メソッド
  # ===引数
  # scene: 切り替え先シーンの名称
  #        シンボルで指定する（例： Director.change_scene(:ending)）
  def self.change_scene(scene)
    @@current_scene = scene
  end
end