# encoding: UTF-8
require "dxruby"

class Bullet < Sprite 

	attr_accessor :type, :vanished, :stage_x, :stage_y

	def initialize(x=0,y=0,image=nil,type=0,stage,isFirst)
		super(x,y,image)

		#タイプ
		@type = type
		#移動量
		@move_x = 0
		@move_y = 0
		#ステージ上の位置(吸着位置)
		@stage_x = (x/25.to_i) - 11
		@stage_y = (y/25.to_i) - 3

		@stage  = stage

		#移動後フラグ,trueの場合ショットヒットしない
		@isMoved = isFirst

		@vanished = false
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
	def set_stage(stagex,stagey)
		@stage_x = stagex.to_i
		@stage_y = stagey.to_i
		self.x = ((stagex.to_i + 11)* 25) 
		self.y = ((stagey.to_i + 3) * 25)
	end

	def checkStageList(column_count, row_count)
		puts "c: #{column_count}, r: #{row_count}"
		@stage.stageList.each do |v|
			#p v
		end
		val = @stage.stageList[column_count][row_count]
		if val == 0 then
			p "#{column_count},,#{row_count},"
			self.set_stage(row_count,column_count)
			@stage.stageList[column_count][row_count] = self
			remove
			return true
		else 
			return false
		end
	end

	#吸着メソッド
	def adsrob(direction,obj=nil)
		puts "adsrob:#{direction},obj:#{obj}"
		#puts "selfx:#{self.x},selfy:#{self.y},,objx#{obj.x},objy#{obj.y}"
		row_count = (((self.x + self.image.width/2)/25).to_i - 11)
		column_count = (((self.y + self.image.height/2)/25).to_i - 3)
		# #ここで吸着先に弾がないかの判定

		unless checkStageList(column_count, row_count) then  
			if direction == :left_up then 
				p "left_up"
				x = obj.x - self.x
				y = obj.y - self.y
				if y > x then
					column_count +=1
				else
					row_count += 1
				end
				unless checkStageList(column_count,row_count) then
					column_count = ((self.y / 25).to_i - 3)
					row_count = ((self.x / 25).to_i - 11)
					checkStageList(column_count,row_count)
				end
			elsif  direction == :right_up then
				p "right_up"
				x = obj.x - self.x
				y = self.y - obj.y
				if y > x then
					column_count +=1
				else
					row_count -= 1
				end
				unless checkStageList(column_count,row_count) then
					column_count = ((self.y / 25).to_i - 3)
					row_count = ((self.x / 25).to_i - 11)
					checkStageList(column_count,row_count)
				end
			elsif direction == :left_down then
				p "left_down"
				x = obj.x - self.x
				y = self.y - self.y
				if y > x then
					column_count -=1
				else
					row_count += 1
				end
				unless checkStageList(column_count,row_count) then
					column_count = ((self.y / 25).to_i - 3)
					row_count = ((self.x / 25).to_i - 11)
					checkStageList(column_count,row_count)
				end
			elsif direction == :right_down then
				p "right_down"
				x = self.x - obj.x
				y = self.y - obj.y		
						if y > x then
					column_count -=1
				else
					row_count -= 1
				end
				unless checkStageList(column_count,row_count) then
					column_count = ((self.y / 25).to_i - 3)
					row_count = ((self.x / 25).to_i - 11)
					checkStageList(column_count,row_count)
				end
			end				
		end
		#連結判定
		@stage.joined_bullet(row_count,column_count,self.type)
	end

	#インスタンスを削除するフラグ
	# def vanished?
 #    	return @vanished
 #  	end
	def hit(obj)
		if @isMoved then
  			return
  		end
		body_img = obj.image
		bullet_img = self.image
		mainimgheight = body_img.height
		mainimgwidth = body_img.width
	
		#左上
		cpwx = self.x 
		cpwy = self.y
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			adsrob(:left_up,obj)
			@isMoved = true
			remove
			return 
		end
	#右上
		cpwx = self.x + (bullet_img.width)
		cpwy = self.y 
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			adsrob(:right_up,obj)
			@isMoved = true
			remove
			return 
		end
		#左下
		cpwx = self.x
		cpwy = self.y + (bullet_img.height)
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			adsrob(:left_down,obj)
			@isMoved = true
			remove
			return 
		end
		#右下
		cpwx = self.x + (bullet_img.width)
		cpwy = self.y + (bullet_img.height)
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			adsrob(:right_down,obj)
			@isMoved = true
			remove
			return 
		end
	end
  	# 他のオブジェクトから衝突した際に呼ばれるメソッド
  	def shot(obj)
  		if @isMoved then
  			return
  		end
  		puts "ショット"
# 		body_img = obj.image
		body_img = obj.image
		bullet_img = self.image
		mainimgheight = body_img.height
		mainimgwidth = body_img.width

		#左上
		cpwx = self.x 
		cpwy = self.y
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			unless body_img.compare(mx,my,[255,248,174]) then
				adsrob(:left_up,obj)
				 @isMoved = true
				remove
				return 
			end
		end
		#右上
		cpwx = self.x + (bullet_img.width)
		cpwy = self.y 
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			unless body_img.compare(mx,my,[255,248,174]) then
				adsrob(:right_up,obj)
				 @isMoved = true
				remove
				return 
			end
		end
		#左下
		cpwx = self.x
		cpwy = self.y + (bullet_img.height)
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			unless body_img.compare(mx,my,[255,248,174]) then
				adsrob(:left_down,obj)
				 @isMoved = true
				remove
				return
			end
		end
		#右下
		cpwx = self.x + (bullet_img.width)
		cpwy = self.y + (bullet_img.height)
		mx = cpwx - obj.x 
		my = cpwy - obj.y 
		if mx >0 && my >0 then
			unless body_img.compare(mx,my,[255,248,174]) then
			adsrob(:right_down,obj)	
		 @isMoved = true
			remove
			return 
			end
		end

  	end

  	def vanished?
  		@vanished
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