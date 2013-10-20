class CreateCatalogsCustomerContracts < ActiveRecord::Migration
  def change
    create_table :catalogs_customer_contracts do |t|
      t.string :name
      t.references :customer, index: true
      t.boolean :def
      t.references :type, index: true

      t.timestamps
    end
  end
end
