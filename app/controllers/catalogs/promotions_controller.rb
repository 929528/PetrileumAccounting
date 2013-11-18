class Catalogs::PromotionsController < CatalogsController
	def index
		super Catalogs::Promotion
	end
	def new
		@promotion = Catalogs::Promotion.new
		render 'new'
	end
	def create
		@promotion = Catalogs::Promotion.new promotion_params
		if @promotion.save
			flash.now[:success] = "Рекламный продукт: #{@promotion.title} создан!"
			super @promotion
		else
			super @promotion, errors = true
		end
	end
	def edit
		@promotion = Catalogs::Promotion.find params[:id]
		render 'edit'
	end
	def update
		@promotion = Catalogs::Promotion.find params[:id]
		if @promotion.update_attributes promotion_params
			flash.now[:success] = "Рекламный продукт: #{@promotion.title} обновлен!"
			render 'update'
		else
			render partial: 'errors', locals: {item: @promotion}
		end
	end
	def destroy
		promotion = Catalogs::Promotion.find params[:id]
		if promotion.destroy
			flash[:success] = "Рекламный продукт: #{promotion.title} удален!"
			redirect_to catalogs_promotions_path
		else
			render partial: 'errors', locals: {item: promotion}
		end
	end

	private 

	def promotion_params
		params.require(:promotion).permit [
			:title, 
			:descr, 
			:usage, 
			:image,
			:href
		]
	end
end
