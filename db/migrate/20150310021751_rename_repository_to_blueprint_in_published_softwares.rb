class RenameRepositoryToBlueprintInPublishedSoftwares < ActiveRecord::Migration
  def change
    rename_column :published_softwares, :website_from_repository, :website_from_blueprint
    rename_column :published_softwares, :name_from_repository, :default_engine_name_from_blueprint
    rename_column :published_softwares, :description_from_repository, :description_from_blueprint
    rename_column :published_softwares, :icon_url_from_repository, :icon_url_from_blueprint
  end
end
