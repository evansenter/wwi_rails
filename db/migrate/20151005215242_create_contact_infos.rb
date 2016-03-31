class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.string :first_name
      t.string :last_name
      t.belongs_to :user
      t.timestamps null: false
    end

    add_foreign_key :contact_infos, :users
  end
end
