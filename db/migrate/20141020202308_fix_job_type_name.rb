class FixJobTypeName < ActiveRecord::Migration
  def change
    rename_column :jobs, :type, :job_type
  end
end
