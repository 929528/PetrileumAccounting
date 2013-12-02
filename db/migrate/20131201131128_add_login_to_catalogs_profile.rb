class AddLoginToCatalogsProfile < ActiveRecord::Migration
  def change
    add_column :catalogs_profiles, :login, :string
  end
end
