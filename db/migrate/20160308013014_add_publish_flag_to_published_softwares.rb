class AddPublishFlagToPublishedSoftwares < ActiveRecord::Migration
  def change
    add_column :published_softwares, :publish, :boolean
  end
end
