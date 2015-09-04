class AddFeesButtonLabelToPublishedSoftwares < ActiveRecord::Migration
  def change
    add_column :published_softwares, :fees_button_label, :string
  end
end
