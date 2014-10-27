class AddLmoFlagToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :lmo, :boolean, :default => false
  end
end
