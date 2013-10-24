class CreateDocumentsActionsTalonsRepaids < ActiveRecord::Migration
  def change
    create_table :documents_actions_talons_repaids do |t|
      t.references :talons_repaid, index: true
      t.references :talon, index: true
      t.decimal :price

      t.timestamps
    end
  end
end
