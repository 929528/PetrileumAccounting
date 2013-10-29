class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :product, index: true
      t.references :department, index: true
      t.decimal :value

      t.timestamps
    end
  end
end
