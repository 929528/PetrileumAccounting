class AddRoleRefToCatalogsUser < ActiveRecord::Migration
  def change
    add_reference :catalogs_users, :role, index: true
  end
end
