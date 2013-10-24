class CreateDocumentsTalonsRepaids < ActiveRecord::Migration
  def change
    create_table :documents_talons_repaids do |t|
      t.references :department, index: true
      t.references :user, index: true
      t.boolean :held

      t.timestamps
    end
  end
end
