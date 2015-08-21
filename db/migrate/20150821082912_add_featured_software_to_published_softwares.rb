class AddFeaturedSoftwareToPublishedSoftwares < ActiveRecord::Migration
  def change
    add_column :published_softwares, :featured_software, :boolean
  end
end
