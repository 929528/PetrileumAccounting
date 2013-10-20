class Catalogs::CustomerContract < ActiveRecord::Base
  belongs_to :customer, inverse_of: :contracts
  belongs_to :type

  validates :name, presence: true
end
