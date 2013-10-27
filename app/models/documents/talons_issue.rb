class Documents::TalonsIssue < ActiveRecord::Base
	belongs_to :department, class_name: 'Catalogs::Department'
	belongs_to :contract, class_name: 'Catalogs::Contract'
	belongs_to :user, class_name: 'Catalogs::User'

	has_many :issues, class_name: 'Actions::Talons::Issue', inverse_of: :talons_issue

	validate :correct_issues
	before_save :change_talons_state, if: :held?

	accepts_nested_attributes_for :issues

	def customer_name
		self.contract.customer.name
	end
	def organization_name
		self.department.organization.name
	end

	def status= status
		self.held = true if status == 'held'
	end
	def held?
		self.held
	end

	private

	def correct_issues
		self.issues.each do |issue|
			unless issue.valid?
				issue.errors.full_messages.each do |msg|
					errors[:base] << "#{msg}"
				end
			end
		end
	end

	def change_talons_state
		self.issues.each do |issue|
			issue.send :change_talon_state
		end
	end
end