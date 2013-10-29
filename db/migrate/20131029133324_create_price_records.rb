class CreatePriceRecords < ActiveRecord::Migration
  def change
    create_table :price_records do |t|
      t.references :price, index: true
      t.references :user, index: true
      t.decimal :value

      t.timestamps
    end
  end
end
