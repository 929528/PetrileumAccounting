class CreateCatalogsPromotions < ActiveRecord::Migration
  def change
    create_table :catalogs_promotions do |t|
      t.attachment :image
      t.string :title
      t.text :descr
      t.string :href

      t.timestamps
    end
  end
end
