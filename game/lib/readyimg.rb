# coding: utf-8

require 'dxruby'

# Window.width  = 800
# Window.height = 600

class Kimeuchi

  def initialize()
    @now = 1
 end

  def loadzahyou
    #y
    @block = Array.new
    File.open("./lib/magatama.txt") do |f|
      f.each do |line|
        @block << line.chomp().split(//)
      end
  end

    @block.each do |array|
      array.map! do |i|
        i.to_i
      end

      @block
    end

  end

  #メイン画像のゲッター
  def img
    @img
  end

  def width
    @img.width
  end

  def height
    @img.height
  end

  def blcolor
    @bulletcolor
  end

  def setblcolor
    #弾の色を取得
    @bulletcolor = Array.new
    width.times do |n|
      @bulletcolor[n] = getBullet
    end
  end

  def getBullet
    #自分自身がつぎにどの色を返すか覚えておく
    case @now
      when 1
        #result = Image.load("./images/bullet_ruby.png")
        result = @now
        #result = Util.load_image("bullet_ruby.png")
      when 2
        #result = Image.load("./images/bullet_shizimi.png")
        result = @now
        #result = Util.load_image("bullet_shizimi.png")
      when 3
        result =@now
        #result = Util.load_image("bullet_perl.png")
        #result = Image.load("./images/bullet_perl.png")
    end

    @now += 1
    @now = 1 if @now == 4
    #@now= (@now +1) %3
    result
  end
end
# # #勾玉の画像
# maingimg = Readyimg.new(Image.load("../images/magatama.png"))
# maingimg.setblcolor
# maingimg.getBulletAry
# #メイン画像の大きさを取得
# mainimgwidth   = maingimg.width
# mainimgheight  = maingimg.height

# #メイン画像取得
# img = maingimg.img

# #弾を配置する座標を保存する配列
# bulletinfo = Array.new
# maingimg.setblcolor

# # 60fps
# Window.loop do

#   Window.draw(0,0,img)
#   #25pxずつ

#   y=0
#   x=0
#   while y < mainimgheight
#       #列
#       while x < mainimgwidth
#         #ピクセルの色と透過度をとってきている
#           color = img[x,y]
#           #ふちだけ弾を描画(画像の透過度がでも255でもない＝画像のふち)
#           if color[0] > 0 && color[0] < 255
#             x = (x/25)*25
#             #弾の色取得
#             blc = maingimg.blcolor
#             #弾の描画位置
#             bulletinfo[x] = [x,(y/25)*25,blc[x]]
#             #弾描画
#             Window.draw(bulletinfo[x][0],bulletinfo[x][1],bulletinfo[x][2])
#             x += 24
#           end
#           x+=1
#       end
#       y+=1
#       #xを0に戻して次の行へ
#       x=0
#    end

#     #エスケープキーで画面終了
#     break if Input.keyPush?(K_ESCAPE)
# end