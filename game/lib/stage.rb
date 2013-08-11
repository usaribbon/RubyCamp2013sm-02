# encoding: Shift_JIS
require "dxruby"
class Stage 
	
	attr_accessor :stageList, :count

	def initialize(stageList)
		
		@count = 0
		#�X�e�[�W��̏����z�u�Ȃǂ�ݒ�
		@stageList = stageList
		@checkedHashMap = Hash::new
		@checkedList = Array.new(18).map{Array.new(20,0)}
	end

	def joined_bullet(x, y, type)
		@count = 0
		search(x,y,type)

		if @count > 2 then
			puts "3�ȏ㌟�m������I"
			p "count ",@count
			p @checkedHashMap
			
			#�Y������Bullet�����܂�
			
		end
 	 end

 	 def search(x,y,type)
 	 	if @checkedList[y][x] == 1
 	 		return
 	 	end

 	 	if @stageList[y][x] == type then
 	 		@checkedList[y][x] = 1
 	 		@checkedHashMap[y.to_s+":"+x.to_s] = type
 	 		@count += 1
 	 	else 
 	 		return
 	 	end

 	 	if y < 17 then
	 	 	search x,y+1,type
			search x,y-1,type
		end
		if x < 19 then
			search x+1,y,type
			search x-1,y,type
		end
	end

	def joined_main_img(x, y, type)

	end

	def bullet_fall()
		if count
		end
	end

	def method
		# �N���A���Ă���Ύ���scene��
		if cleared?
			#Director.change_scene(:next)
		end
	end
	def cleared?
		bullets.empty?
	end
end

class Bullet < Sprite
	attr_accessor :stage_x, :stage_y
	def vanished?
		return @vanished
	end

	def search
	end

end

class StagePoint 
	attr_accessor :x,:y
	def initialize(x,y) 
		@x = x
		@y = y
	end
end

	# tmp = Stage.new( [
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 # 		[0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
	# 	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	# ])

	# tmp.joined_bullet(1,4,1)
	# tmp.joined_bullet(4,6,2)

# @vanished��true��bullet�̂ݔz�񂩂�폜����
#Sprite.clean(bullets)
