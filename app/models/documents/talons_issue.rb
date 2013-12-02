class Documents::TalonsIssue < ActiveRecord::Base
	belongs_to :department, class_name: 'Catalogs::Department'
	belongs_to :contract, class_name: 'Catalogs::Contract'
	belongs_to :user, class_name: 'Catalogs::Employee'

	has_many :issues, class_name: 'Actions::Talons::Issue', validate: false, inverse_of: :talons_issue

	validates_presence_of :department, :contract, :user
	validates :issues, presence: { message: "^Документ не содержит операций" }
	validate :correct_state
	validate :check_correct_actions, if: 'self.errors.empty?'
	before_save :calculate_sum
	before_save :change_talons_state, if: :held?

	accepts_nested_attributes_for :issues

	def customer_name
		self.contract.customer.name
	end
	def organization_name
		self.department.organization.name
	end

	def status= status
		@last_state = self.held
		self.held = (status == 'held') ? true : false
	end
	def held?
		self.held
	end

	private

	def change_talons_state
		self.issues.each do |issue|
			issue.send :change_talon_state
		end
	end
	def check_correct_actions
		self.issues.each do |issue| 
			unless issue.valid?
				issue.errors.full_messages.each do |msg|
					errors[:base] << "#{msg}"
				end
			end
		end
	end
	def correct_state
		errors[:base] << 'Документ проведен' if @last_state
	end

	def calculate_sum
		self.sum = self.issues.inject(0){|sum,el| sum + el.price * el.talon.amount.value}
	end
end