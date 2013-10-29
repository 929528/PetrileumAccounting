class PriceRecord < ActiveRecord::Base
  belongs_to :price, inverse_of: :records
  belongs_to :user, class_name: 'Catalogs::User'
end
