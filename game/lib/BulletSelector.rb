#�e�I��p�̃N���X
class BulletSelector < Sprite
	def initialize(x, y, img, type, game)
		self.x = x
		self.y = y
		self.image = img
		@type = type
		@game = game
	end

	def update
	end
	
	#�}�E�X�|�C���^�Ƃ̐ڐG���̃��\�b�h
	def hit(pointer)
		@game.selectedBullet = @type	
		@game.setSelectedBulletImage(@type)
	end
end
