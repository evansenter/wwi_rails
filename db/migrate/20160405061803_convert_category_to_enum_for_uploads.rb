class ConvertCategoryToEnumForUploads < ActiveRecord::Migration
  def change
    change_column :uploads, :category, :integer, default: 0
  end
end
