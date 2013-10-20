class CreateCatalogsCustomers < ActiveRecord::Migration
  def change
    create_table :catalogs_customers do |t|
      t.string :name
      t.string :fullname

      t.timestamps
    end
  end
end
