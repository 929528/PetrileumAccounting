class AddFreebieToCatalogsContractType < ActiveRecord::Migration
  def change
    add_column :catalogs_contract_types, :freebie, :boolean
  end
end
