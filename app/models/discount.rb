class Discount < ActiveRecord::Base
  belongs_to :product, class_name: 'Catalogs::Product'
  belongs_to :customer, class_name: 'Catalogs::Customer'

  validates_presence_of :product, :customer
end