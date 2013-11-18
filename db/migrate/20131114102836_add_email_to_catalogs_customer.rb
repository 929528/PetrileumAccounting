class AddEmailToCatalogsCustomer < ActiveRecord::Migration
  def change
    add_column :catalogs_customers, :email, :string
  end
end
