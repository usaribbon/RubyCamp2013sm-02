class Game
  #Mainのイメージ
  Ruby_image_path = "../images/ruby.png"
  Magatama_image_path = "../images/magatama.png"
  Shimanekko_image_path =  "../images/shimanekko.png"
  #Bulletのイメージ
  Ruby_bullet_path = "../images/bullet_ruby.png"
  Shizimi_bullet_path = "../images/bullet_shizimi.png"
  Perl_bullet_path = "../images/bullet_perl.png"
  def initialize(mode)
   
    #弾イメージのロード
    @ruby_bullet_img = Util.load_image(Ruby_bullet_path)
    @shizimi_bullet_img = Util.load_image(Shizimi_bullet_path)
    @perl_bullet_img = Util.load_image(Perl_bullet_path)

    #選択している弾 1: ruby, 2: shizimi, 3: perl
    @selectedBullet = 1
    @selectedBullet_img = @ruby_bullet_img
    if @selectedBullet == 2 then
      @selectedBullet_img = @shizimi_bullet_img
    elsif @selectedBullet == 3 then
      @selectedBullet_img = @perl_bullet_img
    end

    #Mainイメージのロード
    @main_image = Util.load_image(Ruby_image_path)
    if mode == 2 then
      @main_image = Util.load_image(Magatama_image_path)
    elsif mode == 3 then
      @main_image = Util.load_image(Shimanekko_image_path)
    end

    #ゲームのステージ管理
    @stage = Stage.new(Array.new(18).map{Array.new(20,0)})

    #カウントダウンタイマーの生成
    #@CDTimer = CDTImer.new

     #台座の生成
    @daiza = Daiza.new(100, 500, Util.load_image("daiza.png"))

    #BulletSelectorの生成
    #@bullet_selector = BulletSelector.new(@main_stage)

    #@shizimis = []
  end

  def play
    if Input.mousePush?(M_LBUTTON)
      #@shizimis << Shizimi.new((@daiza.x + (@daiza.image.width / 2) - (@shizimi_img.width / 2)), @daiza.y, @shizimi_img)
      @bullets << Bullet.new((@daiza.x + (@daiza.image.width / 2) - (@shizimi_img.width / 2)), @daiza.y,@selectedBullet_img,stage)

    end

    @daiza.update
    @daiza.draw

    Sprite.update(@bullets)
    Sprite.draw(@bulllets)
  end
end