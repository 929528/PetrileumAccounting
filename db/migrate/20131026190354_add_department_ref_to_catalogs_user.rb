class AddDepartmentRefToCatalogsUser < ActiveRecord::Migration
  def change
    add_reference :catalogs_users, :department, index: true
  end
end
