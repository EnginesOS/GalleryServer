class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.integer :published_software_id
      t.attachment :image
    end
  end
end
