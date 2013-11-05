class Documents::Actions::Talons::Repaid < ActiveRecord::Base
	belongs_to :talons_repaid, inverse_of: :repaids
	belongs_to :talon, class_name: 'Catalogs::Talon', validate: true

	validate :correct_talon_state
	validate :talon_expires, if: 'self.errors.empty?'
	validates :talon, presence: true

	def barcode= barcode
		self.talon = Catalogs::Talon.find_or_initialize_by barcode: barcode
	end

	def barcode
		self.talon.barcode
	end

	private

	def change_talon_state
		self.talon.update_attribute :state, Catalogs::Talons::State.find_by_name('repaid')
	end

	def correct_talon_state
		errors[:base] << "Талон #{self.talon.barcode} погашен" if self.talon.repaid?
		errors[:base] << "Талон #{self.talon.barcode} еще не выдан " if self.talon.new?
	end

	def talon_expires 
		errors[:base] << "Талон #{self.talon.barcode} просрочен " unless Time.now <= self.talon.expires
	end
end
