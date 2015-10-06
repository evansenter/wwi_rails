class AddRoleToContactInfos < ActiveRecord::Migration
  def change
    add_column :contact_infos, :role, :integer, default: 0
  end
end
