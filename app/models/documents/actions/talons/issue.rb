class Documents::Actions::Talons::Issue < ActiveRecord::Base
	belongs_to :talons_issue, inverse_of: :issues
	belongs_to :talon, class_name: 'Catalogs::Talon'

	scope :customer, -> (customer) { joins(:talons_issue).where(documents_talons_issues: {contract_id: customer.contract_ids}) }

	validate :correct_talon_state
	validates :talon, presence: true
	validate :price_present, :expires_present, if: 'self.new_record?'

	def init
		if self.new_record?
			set_price 
			set_expires
		end
	end

	def contract= contract
		@contract = Catalogs::Contract.find contract
	end
	def contract 
		@contract
	end
	def department= department
		@department = Catalogs::Department.find department
	end
	def department
		@department
	end

	def barcode= barcode
		self.talon = Catalogs::Talon.find_or_initialize_by barcode: barcode
		@product = self.talon.product
	end

	def barcode
		self.talon.barcode
	end
	def init_action
		set_price 
		set_expires
	end
	def set_price
		if @contract && @contract.type.freebie
			self.price = 0
		elsif @contract && (discount = @contract.customer.get_discount_on(@product))
			self.price = discount.value
		elsif department && (price = @department.get_price_on(@product))
			self.price = price.value
		end
	end
	def set_expires 
		self.expires = Time.now + @contract.validity.days if @contract.present?
	end

	private

	def change_talon_state
		self.talon.update_attributes\
		state: Catalogs::Talons::State.find_by_name('issued'),
		contract: self.talons_issue.contract, 
		expires: self.expires
	end

	def correct_talon_state
		errors[:base] << "Талон выдан #{self.talon.barcode}" if self.talon.issued?
	end

	def price_present 
		errors[:base] << "Для подразделения: #{@department.name}, отсутствует цена на продукт: #{@product.name}" unless self.price
	end
	def expires_present
		errors[:base] << "Не удалось установить срок действия талона. Проверьте договор" unless self.expires
	end
end