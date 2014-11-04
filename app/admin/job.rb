ActiveAdmin.register Job do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :description, :level, :job_type, :source, :link, :organization_id, :sponsored, :published, :want_junior, :want_intermediate, :want_senior, :want_executive, :lmo
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  menu priority: 4

  active_admin_import validate: false, csv_options: {:col_sep => "," }, timestamps: true

  batch_action :publish do |selection|
    Job.find(selection).each do |job|
      job.published = true
      job.save
    end
    redirect_to :back
  end

  index do
    selectable_column
    column :title
    column :organization do |job|
      if job.organization
        link_to job.organization.name, edit_admin_organization_path(job.organization.id)
      end
    end
    column :updated_at
    column :sponsored
    column :published
    actions
  end

end
