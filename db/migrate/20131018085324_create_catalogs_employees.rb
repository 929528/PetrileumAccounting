class CreateCatalogsEmployees < ActiveRecord::Migration
  def change
    create_table :catalogs_employees do |t|
      t.string :name
      t.string :surname
      t.string :email

      t.timestamps
    end
  end
end
