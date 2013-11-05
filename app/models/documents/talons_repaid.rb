class Documents::TalonsRepaid < ActiveRecord::Base
	belongs_to :department, class_name: 'Catalogs::Department'
	belongs_to :user, class_name: 'Catalogs::User'

	has_many :repaids, class_name: 'Actions::Talons::Repaid', validate: false

	validates_presence_of :department, :user, :repaids
	validate :correct_state
	validate :check_correct_actions, if: 'self.errors.empty?'
	before_save :change_talons_state, if: :held?

	accepts_nested_attributes_for :repaids

	def status= status
		@last_state = self.held
		self.held = true if status == 'held'
	end
	def held?
		self.held
	end

	private

	def check_correct_actions
		self.repaids.each do |repaid| 
			unless repaid.valid?
				repaid.errors.full_messages.each do |msg|
					errors[:base] << "#{msg}"
				end
			end
		end
	end

	def change_talons_state
		self.repaids.each do |repaid|
			repaid.send :change_talon_state
		end
	end
	def correct_state
		errors[:base] << 'Документ проведен' if @last_state
	end
end
