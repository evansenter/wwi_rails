class AddInstitutionToContactInfos < ActiveRecord::Migration
  def change
    add_column :contact_infos, :institution, :string
  end
end
