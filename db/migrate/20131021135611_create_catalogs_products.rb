class CreateCatalogsProducts < ActiveRecord::Migration
  def change
    create_table :catalogs_products do |t|
      t.string :name
      t.string :fullname
      t.string :symbol

      t.timestamps
    end
  end
end
