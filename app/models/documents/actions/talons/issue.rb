class Documents::Actions::Talons::Issue < ActiveRecord::Base
	belongs_to :talons_issue, inverse_of: :actions
	belongs_to :talon, class_name: 'Catalogs::Talon', validate: true

	validate :correct_talon_state

	def talon_barcode= barcode
		self.talon = Catalogs::Talon.find_or_initialize_by barcode: barcode
	end
	def talon_barcode
		self.talon.barcode
	end

	private

	def change_talon_state
		self.talon.update_attribute :state, Catalogs::Talons::State.find_by_name('issued')
	end

	def correct_talon_state
		errors[:base] << "Талон выдан #{self.talon.barcode}" if self.talon.issued?
	end
end