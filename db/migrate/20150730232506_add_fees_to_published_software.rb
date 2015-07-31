class AddFeesToPublishedSoftware < ActiveRecord::Migration
  def change
    add_column :published_softwares, :fees_comment, :text
    add_column :published_softwares, :fees_buttons_html, :text
  end
end
