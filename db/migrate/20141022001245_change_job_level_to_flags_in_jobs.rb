class ChangeJobLevelToFlagsInJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :want_junior, :boolean
    add_column :jobs, :want_intermediate, :boolean
    add_column :jobs, :want_senior, :boolean
    add_column :jobs, :want_executive, :boolean

    remove_column :jobs, :level
  end

  def self.down
    remove_column :jobs, :want_junior, :boolean
    remove_column :jobs, :want_intermediate, :boolean
    remove_column :jobs, :want_senior, :boolean
    remove_column :jobs, :want_executive, :boolean
    
    add_column :jobs, :level
  end
end
