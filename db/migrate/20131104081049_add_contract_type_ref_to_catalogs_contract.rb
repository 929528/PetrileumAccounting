class AddContractTypeRefToCatalogsContract < ActiveRecord::Migration
  def change
    add_reference :catalogs_contracts, :contract_type, index: true
  end
end
