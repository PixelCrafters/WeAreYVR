class ChangeProfileLinkOrganizationToLinkable < ActiveRecord::Migration
  def up
    rename_column :profile_links, :organization_id, :linkable_id
    add_column :profile_links, :linkable_type, :string
    ProfileLink.reset_column_information
    ProfileLink.update_all(:linkable_type => "Organization")
  end

  def down
    rename_column :profile_links, :linkable_id, :organization_id
    remove_column :profile_links, linkable_type 
  end
end
