class Catalogs::Talon < ActiveRecord::Base
	belongs_to :amount, class_name: 'Talons::Amount'
	belongs_to :state, class_name: 'Talons::State'
	belongs_to :product
	belongs_to :contract

	scope :issued, -> { where(state: Catalogs::Talons::State.find_by_name('issued')) }
	scope :repaid, -> { where(state: Catalogs::Talons::State.find_by_name('repaid')) }
	scope :customer, -> (customer) { where(contract_id: customer.contract_ids) }
	scope :expired, -> { where("expires < ?", Time.now) }
	scope :expire_on, -> (date) { where("expires < ?", Time.now + date) }
	scope :active, -> { where("expires > ?", Time.now) }

	VALID_BARCODE_REGEX = /\A[2,5][1-5]\d{8}\z/
	validates :barcode, presence: true, uniqueness: true
	validates :barcode, numericality: true, length: {is: 10}, allow_blank: true 
	validates :barcode, format: { with: VALID_BARCODE_REGEX }, allow_blank: true
	validates_presence_of :amount, :state, :product, if: 'self.errors.empty?'

	def initialize attributes = {}
		super
		if self.new_record?
			self.amount ||= Catalogs::Talons::Amount.find_by_symbol(self.barcode[0])
			self.product ||= Catalogs::Product.find_by_symbol(self.barcode[1])
			self.state ||= Catalogs::Talons::State.find_by_name("new")
		end
	end

	def issued?
		self.state.name == 'issued'
	end
	def repaid?
		self.state.name == 'repaid'
	end
	def new?
		self.state.name == 'new'
	end
end
