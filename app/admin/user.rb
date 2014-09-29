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
  
  permit_params :email, :name, :image, :email_verified, :email_digest, :startup_genome_slug, :startup_genome_image, :startup_genome_url, :claimed, :created_at, :updated_at, :organization_user_roles, :bio, :why_vancouver, :short_bio

  filter :name
  
  config.batch_actions = true
  batch_action :destroy

  sidebar 'Organizations Claimed by this User', :only => :show do
    table_for Organization.joins(:users).where(:admin_id => user.id) do |t|
      t.column("Org Name") { |organization| organization.name }
    end
  end

  index do
    selectable_column
    actions
    column "Name" do |user|
      link_to user.name, admin_user_path(user.id)  
    end
    column "Tags" do |user|
      raw(user.tags.order('name ASC').map{ |tag| tag.name }.join(", "))
    end
    column :claimed
    column "Date Created" do |user|
      user.created_at.strftime("%F")
    end
  end
  
end
