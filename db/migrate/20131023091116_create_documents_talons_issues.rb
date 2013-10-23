class CreateDocumentsTalonsIssues < ActiveRecord::Migration
  def change
    create_table :documents_talons_issues do |t|
      t.references :department, index: true
      t.references :contract, index: true
      t.references :user, index: true
      t.boolean :held

      t.timestamps
    end
  end
end
