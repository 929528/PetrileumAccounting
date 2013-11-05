class Price < ActiveRecord::Base
	belongs_to :product, class_name: 'Catalogs::Product'
	belongs_to :department, class_name: 'Catalogs::Department'

	has_many :records, class_name: 'PriceRecord', inverse_of: :price, validate: true

	validates_presence_of :product, :department

	validates :value, presence: true, numericality: true
	validate :demand_rate, :current_price, on: :update

	before_save {|price| price.records.build user: @current_user, value: price.value}

	def user= user 
		@current_user = user
	end

	private

	def demand_rate
		if (self.updated_at.to_time > (Time.now - 1.minute))
			difference = (1.minutes - (Time.now - self.updated_at.to_time)).to_i
			errors[:base] << "Зачем так часто обновлять цену? Изменение цены будет доступно через #{difference} секунд"
		end
	end
	def current_price
		price = Price.find_by department_id: self.department.id, product_id: self.product.id
		errors[:base] << "Ты пытаешься установить такую же цену? Я тебя запомнил..." if price.value == self.value
	end
end