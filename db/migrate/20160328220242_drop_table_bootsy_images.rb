class DropTableBootsyImages < ActiveRecord::Migration
  def change
    drop_table :bootsy_images
  end
end
