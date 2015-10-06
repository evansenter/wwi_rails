class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.belongs_to :user
      t.string :full_name
    end
  end
end
