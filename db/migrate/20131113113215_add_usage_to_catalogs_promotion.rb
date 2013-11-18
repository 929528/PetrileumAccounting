class AddUsageToCatalogsPromotion < ActiveRecord::Migration
  def change
    add_column :catalogs_promotions, :usage, :text
  end
end
