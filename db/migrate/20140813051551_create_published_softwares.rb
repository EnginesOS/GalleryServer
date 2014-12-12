class CreatePublishedSoftwares < ActiveRecord::Migration
  def change
    create_table :published_softwares do |t|
      t.string :title
      t.text :detail
      t.string :repository_url
      t.string :website_from_repository
      t.string :name_from_repository
      t.text :description_from_repository
      t.string :icon_url_from_repository
      t.attachment :icon
      t.timestamps
    end
  end
end