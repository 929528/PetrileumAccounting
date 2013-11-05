class AddExpiresToCatalogsTalon < ActiveRecord::Migration
  def change
    add_column :catalogs_talons, :expires, :datetime
  end
end
