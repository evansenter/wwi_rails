class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |table|
      table.string :title
      table.string :category
      table.string :s3_url
      table.belongs_to :user, index: true
      table.timestamps null: false
    end

    add_foreign_key :uploads, :users
  end
end
