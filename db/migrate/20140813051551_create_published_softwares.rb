class CreatePublishedSoftwares < ActiveRecord::Migration
  def change
    create_table :published_softwares do |t|
      t.string :short_name
      t.string :full_name
      t.text :description
      t.string :home_page
      t.string :image_url
      t.string :repository

      t.timestamps
    end
  end
end
