class AddContractRefToDocumentsActionsTalonsRepaids < ActiveRecord::Migration
  def change
    add_reference :documents_actions_talons_repaids, :contract, index: true
  end
end
