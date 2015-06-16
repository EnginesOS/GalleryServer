class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :published_software_id
      t.string :embed_code
    end
  end
end
