class Documents::TalonsRepaid < ActiveRecord::Base
	belongs_to :department, class_name: 'Catalogs::Department'
	belongs_to :user, class_name: 'Catalogs::User'

	has_many :actions, class_name: 'Actions::Talons::Repaid', inverse_of: :talons_repaid

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
		return [:department, actions_attributes: [:id, :talon_barcode, :price]]
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
