# encoding: UTF-8
require "dxruby"

class Bullet < Sprite 

	attr_accessor :type

	def initialize(x=0,y=0,image=nil,type=0,stage)
		super(x,y,image)

		#タイプ
		@type = type
		#移動量
		@move_x = 5
		@move_y = 2
		#ステージ上の位置(吸着位置)
		@stage_x = 0
		@stage_y = 0

		@stage  = stage
	end

	#移動量，発射時に設定
	def set_move_point(x=0,y=0) 
		@move_x = x
		@move_y = y
	end

	#ステージ上の位置
	def set_stage(x,y)
		@stage_x = x
		@stage_y = y
	end

	#吸着メソッド
	def adsrob
		# row_count = self.x /25
		# column_count = self.y/25
		# #ここで吸着先に弾がないかの判定
		# self.x = row_count*25
		# self.y = column_count*25

		# #連結判定
		# stage.joined_bullet(self.x,self.y,self.type)
	end

	#インスタンスを削除するフラグ
	def vanished?
    	return @vanished
  	end

  	# 他のオブジェクトから衝突された際に呼ばれるメソッド
  	def hit(obj)
  		#勾玉の時は，衝突判定
  		#それ以外の時は，あたり判定のチェック
  	#	if obj.type == self.@type then
  			#連結判定
  			
  	#	end

  		#吸着

  		#消すとき
    	@vanished = true
  	end

	def update
		self.x += @move_x
		self.y += @move_y
		#跳ね返り
		if self.x < 0 || self.x > 475 then
			@move_x *= -1			
		end
		if self.y < 0 || self.y > 450 then
			 @vanished = true
			 vanish
		end
	end
end

# Window.width = 500
# Window.height = 450

# img = Image.load("../img/bullet_ruby.png")

# bullet = Bullet.new(0,0,img)

# Window.loop do
# 	break if Input.keyPush?(K_ESCAPE)
# 	bullet.draw
# 	bullet.update
# end