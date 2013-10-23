class CreateCatalogsTalons < ActiveRecord::Migration
  def change
    create_table :catalogs_talons do |t|
      t.references :amount, index: true
      t.references :state, index: true
      t.references :product, index: true
      t.string :barcode
      t.references :customer, index: true

      t.timestamps
    end
  end
end
