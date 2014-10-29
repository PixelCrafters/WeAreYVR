ActiveAdmin.register User do

  menu priority: 3
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  permit_params :email, :name, :image, :email_verified, :email_digest, :startup_genome_slug, :startup_genome_image, :startup_genome_url, :claimed, :created_at, :updated_at, :organization_user_roles, :bio, :why_vancouver, :short_bio, :profile_links

  filter :name
  
  config.batch_actions = true
  batch_action :destroy

  sidebar 'Organizations Claimed by this User', :only => :show do
    table_for Organization.joins(:users).where(:admin_id => user.id) do |t|
      t.column("Org Name") { |organization| link_to organization.name, admin_organization_path(organization.id) }
    end
  end

  action_item :only => :show do
    link_to('Add Profile Link', add_profile_link_admin_user_path(user))
  end

  member_action :add_profile_link do
    @user = User.find(params[:id])
    profileLink = ProfileLink.create(:linkable => @user)
    redirect_to edit_admin_profile_link_path(profileLink)
  end

  index do
    selectable_column
    column "Name" do |user|
      link_to user.name, user_path(user), target: '_blank'
    end
    column "Tags" do |user|
      raw(user.tags.order('name ASC').map{ |tag| tag.name }.join(", "))
    end
    column :claimed
    column "Date Created" do |user|
      user.created_at.strftime("%F")
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :short_bio
      row :bio
      row :why_vancouver
      row :email_verified
      row "Profile Links" do
        table_for user.profile_links do
          column "Name" do |profileLink|
            profileLink.name
          end
          column "URL" do |profileLink|
            profileLink.url
          end
          column "Image" do |profileLink|
            profileLink.image
          end
          column "Actions" do |profileLink|
            link_to("Edit", edit_admin_profile_link_path(profileLink)) + ' ' +
            link_to("Delete", admin_profile_link_path(profileLink), method: :delete)
          end
        end
      end
      row "Roles" do
        table_for user.organization_user_roles do
          column "Role" do |userrole|
            userrole.role.name
          end
          column "Organization" do |userrole|
            link_to userrole.organization.name, [ :admin, userrole.organization ]
          end
          column "Actions" do |userrole|
            link_to("Edit", edit_admin_organization_user_role_path(userrole)) + ' ' +
            link_to("Delete", admin_organization_user_role_path(userrole), method: :delete)
          end
        end
      end
      row :startup_genome_slug
      row :startup_genome_image
      row :startup_genome_url
      row :created_at
      row :updated_at
      
      
    end
  end
  
end
