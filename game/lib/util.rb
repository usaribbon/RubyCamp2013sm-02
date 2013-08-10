# ゲーム内の各種便利メソッドの集合
module Util
  Blue = [0, 0, 255]  # 青色

  module_function

  # 引数で指定した画像をimagesディレクトリから読み込む
  def load_image(filename)
    return Image.load(File.join(File.dirname(__FILE__), "..", "images", filename))
  end

  # 引数で指定した二次元座標系を配列のインデックスに変換
  def coord_to_pos(x, y)
    return (y * Game::ROW_PIECES) + x
  end

  # 引数で指定した配列のインデックスを二次元座標系に変換
  def pos_to_coord(pos)
    return pos_x(pos), pos_y(pos)
  end

  # 引数で指定した配列のインデックスを二次元座標のX値に変換
  def pos_x(pos)
    pos % Game::ROW_PIECES
  end

  # 引数で指定した配列のインデックスを二次元座標のY値に変換
  def pos_y(pos)
    pos / Game::ROW_PIECES
  end
end