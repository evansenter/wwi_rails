class CreateJobRoleForContactInfos < ActiveRecord::Migration
  def change
    add_column :contact_infos, :job_role, :integer, default: 0
  end
end
