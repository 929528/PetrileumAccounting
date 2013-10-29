class Price < ActiveRecord::Base
  belongs_to :product, class_name: 'Catalogs::Product'
  belongs_to :department, class_name: 'Catalogs::Department'

  has_many :records, class_name: 'PriceRecord', inverse_of: :price
end
