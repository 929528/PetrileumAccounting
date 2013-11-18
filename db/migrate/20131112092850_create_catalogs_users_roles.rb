class CreateCatalogsUsersRoles < ActiveRecord::Migration
  def change
    create_table :catalogs_users_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
