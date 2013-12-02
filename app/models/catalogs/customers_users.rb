class Catalogs::CustomersUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
end
