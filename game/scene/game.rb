# encoding: UTF-8
class Game
  #Mainのイメージ
  Ruby_image_path = "ruby.png"
  Magatama_image_path = "magatama.png"
  Shimanekko_image_path =  "shimanekko.png"
  #Bulletのイメージ
  Ruby_bullet_path = "bullet_ruby.png"
  Shizimi_bullet_path = "bullet_shizimi.png"
  Perl_bullet_path = "bullet_perl.png"
  Selecting_img_path = "maru.png"


  attr_accessor :selectedBullet

  def initialize(mode)

    #ウィンドウサイズ
    Window.width = 800
    Window.height = 600
    #背景色
    #Window.bgcolor = [255,255,255]#白
   
    #弾イメージのロード
    @ruby_bullet_img = Util.load_image(Ruby_bullet_path)
    @shizimi_bullet_img = Util.load_image(Shizimi_bullet_path)
    @perl_bullet_img = Util.load_image(Perl_bullet_path)

    #選択中イメージのロードと生成
    @selecting_img = Util.load_image(Selecting_img_path)
    @selecting = Sprite.new(118, 0, @selecting_img)

    #初期弾をRuby:1にする
    @selectedBullet = 1
    setSelectedBulletImage(@selectedBullet) 


    @kimeuchi = Kimeuchi.new
    @hairetu =@kimeuchi.loadzahyou
    @resimg = Array.new(18).map! {Array.new}
    18.times do |y|
      20.times do |x|
        if @hairetu[y][x] == 1
          @resimg[y][x] = @kimeuchi.getBullet
        end
      end
    end




    @main_image = Util.load_image(Ruby_image_path)
    if mode == 2 then
      @main_image = Util.load_image(Magatama_image_path)
    elsif mode == 3 then
      @main_image = Util.load_image(Shimanekko_image_path)
    end

    #ゲームのステージ管理
    @stage = Stage.new(Array.new(18).map{Array.new(20,0)})

    #カウントダウンタイマーの生成
    @cdTimer = CDTimer.new(32)

     #台座の生成
    @daiza = Daiza.new(275, 500, Util.load_image("daiza.png"))

    #マウスポインタを生成
    @pointer = Sprite.new(0,0)
    @pointer.collision = [0, 0, 1]
    #弾選択の配列を生成
    @selectors = []
    @selectors << BulletSelector.new(120, 215, @ruby_bullet_img, 1, self)
    @selectors << BulletSelector.new(120, 260, @shizimi_bullet_img, 2, self)
    @selectors << BulletSelector.new(120, 305, @perl_bullet_img, 3, self)

    #残り時間タイトル
    @timeleft_view = Sprite.new(60,25,Util.load_image("timeleft.png"))
    #しまねっこ画像
    @shimaneko_view = Sprite.new(50,412,Util.load_image("shimanekko_left_under.png"))
    #影軸画像
    @kakejiku_view = Sprite.new(70,120,Util.load_image("kakejiku.png"))

    #土台のバー上
    @daiza_up_bar = Sprite.new(275,25,Util.load_image("daiza_bar.png"))
    #土台のバー下
    @daiza_under_bar = Sprite.new(275,525,Util.load_image("daiza_bar.png"))

    #背景
    @back_ground = Sprite.new(0,0,Util.load_image("game_bg.png"))

    #弾格納用配列
    @bullets = []


    #Mainイメージのロード
  #  magatama_img = Image.load("./images/magatama.png")
   # magatama_img.setColorKey([0, 0, 0])
    #@main_image = Sprite.new(275,80,magatama_img)
	@main_image.setColorKey([255, 248, 174])
	@main_image = Sprite.new(275,80,@main_image)
    #@main_image = Sprite.new(275,80,@main_image)

  end

  def play
    #back ground 
    @back_ground.draw

    @main_image.draw
    Sprite.check(@bullets,@main_image)
	Sprite.check(@bullets)
    #時間表示
    @cdTimer.reload
    Window.drawFont(100, 60, "#{@cdTimer.min}:#{@cdTimer.sec}", @cdTimer,{:color=>[0,0,0]} )



    #18.times do |y|
    # 20.times do |x|
    #    if @hairetu[y][x] == 1
    #      Window.draw(x*25+290,y*25+80,@resimg[y][x])
    #    end
    #  end
    #end




    if Input.mousePush?(M_LBUTTON)
       #マウス位置の取得
      @pointer.x = Input.mousePosX
      @pointer.y = Input.mousePosY
      #ステージ上なら弾を発射
      if @pointer.x >= 250 
        position_x = (@daiza.x + (@daiza.image.width / 2) - (@selectedBullet_img.width / 2))
       position_y = ( @daiza.direction != :up ? @daiza.y + @daiza.rimage.height : @daiza.y)
        bullet = Bullet.new(position_x, position_y,@selectedBullet_img,@selectedBullet,@stage)
        move_point_x = Input.mousePosX - position_x
        move_point_y = Input.mousePosY - position_y
        #x方向のマイナス判定
        flagx = nil
        if move_point_x < 0 then
           flagx = 1
        end
        flagy =nil
        if move_point_y < 0 then 
          flagy = 1
        end
        #三角関数を用いて値を丸める
        a = Math.atan(move_point_y.to_f / move_point_x.to_f)
        y = Math.sin(a) 
        x = Math.cos(a)
        #x方向のマイナス
        if flagx then
          x *= -1
        end
        if flagy then
          y *= -1
        end

        #移動量を設定
        bullet.set_move_point(x*3,y*3)
        @bullets << bullet
      else
      #弾選択と衝突判定
        Sprite.check(@pointer, @selectors)
      end
    end

   #残り時間のタイトル
    @timeleft_view.draw
    #しまねこ
    @shimaneko_view.draw
    #掛け軸
    @kakejiku_view.draw

    #弾選択エリアの弾描画
    Sprite.draw(@selectors.compact)
    @selecting.draw

    #土台バー
    @daiza_under_bar.draw
    @daiza_up_bar.draw

    #土台
    @daiza.update
    @daiza.draw

    Sprite.update(@bullets)
    Sprite.draw(@bullets)

    if @cdTimer.min == 0 && @cdTimer.sec <= 0
      Director.change_scene(:gameover)
    end
  end

  def round_point(point, num)
    if point > num then 
      point = point / num + point % num
    elsif point < -num then
      point = point / num + point % num
    end
    return point
  end

  def setSelectedBulletImage(type)
    #選択している弾 1: ruby, 2: shizimi, 3: perl
    if type == 1
      @selectedBullet_img = @ruby_bullet_img
    elsif type == 2 then
      @selectedBullet_img = @shizimi_bullet_img
    elsif type == 3 then
      @selectedBullet_img = @perl_bullet_img
    end
    #選択中の弾によって選択中イメージのy座標をずらす
    @selecting.y = 212 + 45 * (type - 1)
  end
end