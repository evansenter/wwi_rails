class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |table|
      table.string :title
      table.string :category
      table.belongs_to :user
      table.timestamps null: false
    end

    add_foreign_key :uploads, :users
  end
end
