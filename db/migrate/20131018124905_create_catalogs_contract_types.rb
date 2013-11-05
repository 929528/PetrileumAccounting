class CreateCatalogsContractTypes < ActiveRecord::Migration
  def change
    create_table :catalogs_contract_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
