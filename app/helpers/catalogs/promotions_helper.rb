module Catalogs::PromotionsHelper
	def buttons
		buttons = []
		buttons << {title: "Создать рекламный продукт", request_path: new_catalogs_promotion_path}
		return buttons
	end
end
