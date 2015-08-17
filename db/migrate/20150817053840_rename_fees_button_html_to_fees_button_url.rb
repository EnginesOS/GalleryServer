class RenameFeesButtonHtmlToFeesButtonUrl < ActiveRecord::Migration
  def change
    rename_column :published_softwares, :fees_buttons_html, :fees_button_url
  end
end
