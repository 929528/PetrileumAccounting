class CreateDocumentsActionsTalonsIssues < ActiveRecord::Migration
  def change
    create_table :documents_actions_talons_issues do |t|
      t.references :talons_issue, index: true
      t.references :talon, index: true
      t.decimal :price
      t.datetime :expires

      t.timestamps
    end
  end
end
