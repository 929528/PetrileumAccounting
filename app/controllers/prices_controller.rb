class PricesController < ApplicationController
	def index
		childrens_count = params[:childrens_count]
		@records = PriceRecord.all.order('id DESC').limit(10).offset childrens_count
	end
	def create
		@price = Price.new(price_params).tap {|p| p.user = current_user}
		if Price.find_by department_id: @price.department.id, product_id: @price.product.id 
			@price.errors[:base] << "Цена задана в первый раз, необходимо обновить страницу для ее изменения"
			render partial: 'price_error', locals: {item: @price}
		else
			if @price.save
				flash.now[:success] = "Для продукта: #{@price.product.name}, создана цена: #{@price.value}"
				render 'add_history'
			else
				render partial: 'price_error', locals: {item: @price}
			end
		end
	end
	def update
		@price = Price.find(params[:id]).tap do |p| 
			p.user = current_user
			p.value = price_params[:value]
		end
		if @price.save
			flash.now[:success] = "Для продукта: #{@price.product.name}, изменена цена: #{@price.value}"
			render 'add_history'
		else
			render partial: 'price_error', locals: {item: @price}
		end
	end
	def show
		@timestamp = params[:timestamp]
		@price_record = PriceRecord.find params[:id]
		render 'show'
	end

	private

	def price_params
		params.require(:price).permit :value, :department_id, :product_id
	end
end
