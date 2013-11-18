class AddActivatedToCatalogsCustomer < ActiveRecord::Migration
  def change
    add_column :catalogs_customers, :activated, :boolean, default: false
  end
end