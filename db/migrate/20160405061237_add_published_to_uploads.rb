class AddPublishedToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :published, :boolean, default: false
    add_index :uploads, :published
  end
end
