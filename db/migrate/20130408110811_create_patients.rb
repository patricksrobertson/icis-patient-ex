class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :photo_url

      t.timestamps
    end
  end
end
