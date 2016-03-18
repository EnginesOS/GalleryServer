class CreateMobileApps < ActiveRecord::Migration
  def change
    create_table :mobile_apps do |t|
      t.integer :published_software_id
      t.string :name
      t.text :description
      t.string :url
      t.attachment :image
    end
  end
end
