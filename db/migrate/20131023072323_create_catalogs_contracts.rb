class CreateCatalogsContracts < ActiveRecord::Migration
  def change
    create_table :catalogs_contracts do |t|
      t.string :name
      t.references :customer, index: true
      t.boolean :def

      t.timestamps
    end
  end
end
