ActiveAdmin.register Job do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :description, :level, :job_type, :source, :link, :organization_id, :sponsored, :published
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  batch_action :publish do |selection|
    Job.find(selection).each do |job|
      job.published = true
      job.save
    end
    redirect_to :back
  end


end
