class PriceRecord < ActiveRecord::Base
  belongs_to :price, inverse_of: :records
  belongs_to :user, class_name: 'Catalogs::Employee'

  validates_presence_of :price, :user, :value
  validates :value, numericality: true
end
