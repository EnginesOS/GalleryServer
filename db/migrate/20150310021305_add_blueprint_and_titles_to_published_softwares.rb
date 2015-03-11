class AddBlueprintAndTitlesToPublishedSoftwares < ActiveRecord::Migration
  def change
    add_column :published_softwares, :blueprint, :text
    add_column :published_softwares, :full_title_from_blueprint, :string
    add_column :published_softwares, :short_title_from_blueprint, :string
  end
end
