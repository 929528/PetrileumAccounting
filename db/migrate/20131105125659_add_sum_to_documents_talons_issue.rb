class AddSumToDocumentsTalonsIssue < ActiveRecord::Migration
  def change
    add_column :documents_talons_issues, :sum, :decimal
  end
end
