class CreateCatalogsEmployeesRights < ActiveRecord::Migration
  def change
    create_table :catalogs_employees_rights do |t|
      t.string :name

      t.timestamps
    end
  end
end
