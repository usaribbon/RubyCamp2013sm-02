# encoding: UTF-8
require "dxruby"

class Bullet < Sprite 

	attr_accessor :type

	def initialize(x=0,y=0,image=nil,type=0,stage)
		super(x,y,image)

		#タイプ
		@type = type
		#移動量
		@move_x = 0
		@move_y = 0
		#ステージ上の位置(吸着位置)
		# @stage_x = 0
		# @stage_y = 0

		@stage  = stage
	end

	def remove 
		@move_x = 0
		@move_y = 0
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
		row_count = (self.x/25) -11
		column_count = (self.y/25) -3
		# #ここで吸着先に弾がないかの判定
		val = @stage.stageList[column_count][row_count]
		p val
		if val  == 0 then 
			self.x = (row_count+11)*25 
			self.y = (column_count+3)*25
			remove
		end


		# #連結判定
		@stage.joined_bullet(row_count,column_count,self.type)
	end

	#インスタンスを削除するフラグ
	# def vanished?
 #    	return @vanished
 #  	end
	def hit(obj)
		body_img = obj.image
		bullet_img = self.image
		
		cpwx = self.x + (bullet_img.width/2)
		cpwy = self.y + (bullet_img.height/2)
		mainimgheight = body_img.height
		mainimgwidth = body_img.width
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			unless body_img.compare(mx,my,[255,248,174]) then
				adsrob	
				remove
			end
		end
	end
  	# 他のオブジェクトから衝突した際に呼ばれるメソッド
  	def shot(obj)

		body_img = obj.image
		bullet_img = self.image
		
		cpwx = self.x + (bullet_img.width/2)
		cpwy = self.y + (bullet_img.height/2)
		mainimgheight = body_img.height
		mainimgwidth = body_img.width
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			unless body_img.compare(mx,my,[255,248,174]) then
			adsrob	
remove
				
			end
		end
  		#勾玉の時は，衝突判定
  		#それ以外の時は，あたり判定のチェック
  	#	if obj.type == self.@type then
  			#連結判定
  			
  	#	end

  		#吸着

  		#消すとき
    	# @vanished = true
  	end

	def update
		#p self.x
		#p self.y
		self.x += @move_x
		self.y += @move_y
		#跳ね返り
		# if self.x < 0 || self.x > 475 then
		if self.x < 275 || self.x > 750 then
			@move_x *= -1			
		end
		if self.y < 75 || self.y > 500 then
		# if self.y < 0 || self.y > 425 then
			@move_y *= -1
		end
	end
end

# Window.width = 500
# Window.height = 450

# img = Util.load_image("./bullet_ruby.png")

# bullet = Bullet.new(0,0,img)

# Window.loop do
# 	break if Input.keyPush?(K_ESCAPE)
# 	bullet.draw
# 	bullet.update
# end