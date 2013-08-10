require_relative 'lib/daiza'
require_relative 'lib/shizimi'
require_relative 'lib/stage'
require_relative 'lib/bullet'

require_relative 'lib/util'

require_relative 'scene/title'
require_relative 'scene/game'
require_relative 'scene/ending'

# ゲーム進行管理用クラス
class Director
  # 初期化処理
  def initialize
    # ゲームを構成する各シーンの管理オブジェクトを生成
    @@scenes = {}
    @@scenes[:title]  = Title.new
    @@scenes[:game]   = Game.new(1)
    @@scenes[:ending] = Ending.new
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