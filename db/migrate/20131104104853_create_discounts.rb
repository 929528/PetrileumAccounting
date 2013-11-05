class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.references :product, index: true
      t.references :customer, index: true
      t.decimal :value

      t.timestamps
    end
  end
end
