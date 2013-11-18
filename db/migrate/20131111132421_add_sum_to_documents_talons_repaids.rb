class AddSumToDocumentsTalonsRepaids < ActiveRecord::Migration
  def change
    add_column :documents_talons_repaids, :sum, :decimal
  end
end
