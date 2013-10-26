class Catalogs::ProductsController < CatalogsController
	def index
		super Catalogs::Product
	end
	def new
		@product = Catalogs::Product.new
		render 'new'
	end
	def create
		@product = Catalogs::Product.new product_params
		if @product.save
			flash.now[:success] = "Продукт: #{@product.name} создан!"
			render 'create'
		else
			render partial: 'errors', locals: {item: @product}
		end
	end
	def edit
		@product = Catalogs::Product.find params[:id]
		render 'edit'
	end
	def update
		@product = Catalogs::Product.find params[:id]
		if @product.update_attributes product_params
			flash.now[:success] = "Продукт: #{@product.name} обновлен!"
			render 'update'
		else
			render partial: 'errors', locals: {item: @product}
		end
	end
	private

	def product_params
		params.require(:product).permit  [:name, :fullname]
	end
end