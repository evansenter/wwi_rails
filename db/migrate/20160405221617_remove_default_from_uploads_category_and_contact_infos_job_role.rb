class RemoveDefaultFromUploadsCategoryAndContactInfosJobRole < ActiveRecord::Migration
  def change
    change_column_default :uploads, :category, nil
    change_column_default :contact_infos, :job_role, nil
  end
end
