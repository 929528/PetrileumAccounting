class AddTalonsValidityToCatalogsContract < ActiveRecord::Migration
  def change
    add_column :catalogs_contracts, :validity, :integer
  end
end
