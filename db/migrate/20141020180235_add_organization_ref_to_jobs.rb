class AddOrganizationRefToJobs < ActiveRecord::Migration
  def change
    add_reference :jobs, :organization, index: true
  end
end
