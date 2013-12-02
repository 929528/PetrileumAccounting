class AddLastnameToCatalogsEmployee < ActiveRecord::Migration
  def change
    add_column :catalogs_employees, :lastname, :string
  end
end
