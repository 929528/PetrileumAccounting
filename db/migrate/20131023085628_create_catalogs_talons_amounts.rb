class CreateCatalogsTalonsAmounts < ActiveRecord::Migration
  def change
    create_table :catalogs_talons_amounts do |t|
      t.integer :value
      t.string :symbol

      t.timestamps
    end
  end
end
