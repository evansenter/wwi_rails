class DropTableBootsyImageGalleries < ActiveRecord::Migration
  def change
    drop_table :bootsy_image_galleries
  end
end
