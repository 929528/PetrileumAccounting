class CreateCatalogsUsersRights < ActiveRecord::Migration
  def change
    create_table :catalogs_users_rights do |t|
      t.string :name

      t.timestamps
    end
  end
end
