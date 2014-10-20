class AddSponsoredToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :sponsored, :boolean
  end
end
