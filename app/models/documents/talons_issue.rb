class Documents::TalonsIssue < ActiveRecord::Base
	belongs_to :department, class_name: 'Catalogs::Department'
	belongs_to :contract, class_name: 'Catalogs::Contract'
	belongs_to :user, class_name: 'Catalogs::User'

	has_many :actions, class_name: 'Actions::Talons::Issue', inverse_of: :talons_issue

	validate :correct_actions
	before_save :change_talons_state, if: :held?

	accepts_nested_attributes_for :actions

	def status= status
		self.held = true if status == 'held'
	end
	def held?
		self.held
	end

	def self.strong_params
		return [:contract, :department, actions_attributes: [:id, :talon_barcode, :price, :expires]]
	end

	private

	def correct_actions
		self.actions.each do |action|
			unless action.valid?
				action.errors.full_messages.each do |msg|
					errors[:base] << "#{msg}"
				end
			end
		end
	end

	def change_talons_state
		self.actions.each do |action|
			action.send :change_talon_state
		end
	end
end