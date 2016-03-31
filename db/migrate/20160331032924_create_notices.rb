class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |table|
      table.string :title
      table.text :body
      table.belongs_to :user
      table.timestamps null: false
    end

    add_foreign_key :notices, :users
  end
end
