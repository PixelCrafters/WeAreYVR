  ActiveAdmin.register Organization do

  menu priority: 2
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

  permit_params :name, :headline, :description, :founded, :active, :claimed, :hiring, :hiring_url, :admin_id, :organization_user_roles, :why_vancouver, :hiring_roles, :number_of_employees, :neighbourhood, :profile_links

  # AA doesn't handle has_many well, so don't use those
  filter :name
  filter :types
  filter :active
  filter :claimed
  filter :hiring

  action_item :only => :show do
    link_to('Add User Role', add_user_role_admin_organization_path(organization))
  end

  action_item :only => :show do
    link_to('Add Profile Link', add_profile_link_admin_organization_path(organization))
  end

  member_action :add_user_role do
    @organization = Organization.find(params[:id])
    orgUserRole = OrganizationUserRole.create(:organization => @organization)
    redirect_to edit_admin_organization_user_role_path(orgUserRole)
  end

  member_action :add_profile_link do
    @organization = Organization.find(params[:id])
    profileLink = ProfileLink.create(:linkable => @organization)
    redirect_to edit_admin_profile_link_path(profileLink)
  end

  # need to find by ID
  before_filter do
    Organization.class_eval do
      def to_param
        id.to_s
      end
    end
  end

  index do
    selectable_column
    column :name, :min_width => "100px" do |organization|
      link_to organization.name, organization_path(organization), target: '_blank'
    end
    column "Headline", :min_width => "250px" do |organization|
          truncate(organization.headline, omision: "…", length: 100)
        end

    column "Types" do |organization|
      raw(organization.types.order('name ASC').map{ |type| link_to type.name, [ :admin, type ]}.join(", "))
    end
        
    column "Claimed By" do |organization|
      if organization.claimed && !organization.admin_id.nil?
        usr = User.find(organization.admin_id)
        link_to usr.name, admin_user_path(organization.admin_id)  
      else
        "None"
      end
    end 
    
    column :active
    column :founded
    column :hiring
    column "Date Created" do |organization|
      organization.created_at.strftime("%F")
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :headline
      row :description
      table_for organization.types.order('name ASC') do
        column "Types" do |type|
          link_to type.name, [ :admin, type ]
        end
      end
      row :founded
      row :why_vancouver 
      row :number_of_employees 
      row :hiring_roles 
      row :claimed
      row :active
      row "Profile Links" do
        table_for organization.profile_links do
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
      row "Admin" do
        if !organization.admin_id.nil?
          User.find(organization.admin_id)  
        end
      end
      row :hiring
      row "Roles" do
        table_for organization.organization_user_roles do
          column "Role" do |userrole|
            userrole.role.name
          end
          column "User" do |userrole|
            link_to userrole.user.name, [ :admin, userrole.user ]
          end
          column "Actions" do |userrole|
            link_to("Edit", edit_admin_organization_user_role_path(userrole)) + ' ' +
            link_to("Delete", admin_organization_user_role_path(userrole), method: :delete)
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Add/Edit Organization" do
      f.input :name
      f.input :headline
      f.input :image
      f.input :description
      f.input :types
      f.input :active
      f.input :hiring
      f.input :founded 
      f.input :why_vancouver 
      f.input :number_of_employees 
      f.input :hiring_roles 
      f.input :neighbourhood 
      f.input :admin_id, :label => 'Claimed by', :as => :select, :collection => User.order(:name).all.map{|u| ["#{u.name}", u.id]}
    end
    f.actions
  end


end
