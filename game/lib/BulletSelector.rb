#弾選択用のクラス
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
	
	#マウスポインタとの接触時のメソッド
	def hit(pointer)
		@game.selectedBullet = @type	
		@game.setSelectedBulletImage(@type)
	end
end
