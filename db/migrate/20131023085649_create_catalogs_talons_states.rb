class CreateCatalogsTalonsStates < ActiveRecord::Migration
  def change
    create_table :catalogs_talons_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
