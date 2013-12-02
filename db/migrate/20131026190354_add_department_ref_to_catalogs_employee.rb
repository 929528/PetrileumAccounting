class AddDepartmentRefToCatalogsEmployee < ActiveRecord::Migration
  def change
    add_reference :catalogs_employees, :department, index: true
  end
end
