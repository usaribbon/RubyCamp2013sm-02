# coding: utf-8

require 'dxruby'

class Kimeuchi

  def initialize()
    @now = 1
  end

  def loadBulletFile(scene)
    @block = Array.new

    case scene
      when 1
        filepath = "./lib/shimanekko.txt"
      when 2
        filepath = "./lib/ruby.txt"
      when 3
        filepath = "./lib/magatama.txt"
    end
    File.open(filepath) do |f|
      f.each do |line|
        @block << line.chomp().split(//)
      end
    end

    @block.each do |array|
      array.map! do |i|
        i.to_i
      end
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

 #   @now += 1
  #  @now = 1 if @now == 4
    #@now= (@now +1) %3
    result
  end
end