class CreateCatalogsProfiles < ActiveRecord::Migration
  def change
    create_table :catalogs_profiles do |t|
      t.string :password_digest
      t.string :remember_token
      t.references :user, polymorphic: true, index: true
      t.string :preferences

      t.timestamps
    end
  end
end
