class AddFreebieToCatalogsContract < ActiveRecord::Migration
  def change
    add_column :catalogs_contracts, :freebie, :boolean
  end
end
