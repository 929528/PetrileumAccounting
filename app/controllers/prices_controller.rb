class PricesController < ApplicationController
	def index
		@records = PriceRecord.all
	end
	def create
		price = Price.new price_params
		if Price.find_by department_id: price.department.id, product_id: price.product.id 
			flash.now[:error] = "Ошибка"
			render 'price_error'
		else
			@history = price.records.build user: current_user, value: price.value
			if price.save!
				flash.now[:success] = "Создали новую цену"
			else
				flash.now[:error] = "Ошибка"
			end
			render 'add_history'
		end
	end
	def update
		price = Price.find params[:id]
		if price.update_attribute :value, price_params[:value] 
			@history = price.records.build user: current_user, value: price.value
			@history.save!
			flash.now[:success] = "Изменили цену"
		end
		render 'add_history'
	end

	private

	def price_params
		params.require(:price).permit :value, :department_id, :product_id
	end
end
