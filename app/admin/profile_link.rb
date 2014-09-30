ActiveAdmin.register ProfileLink do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :url, :image, :linkable
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  form do |f|
    f.inputs "Add/Edit Profile Link" do
      f.input :name
      f.input :url
      f.input :image
    end
    f.actions
  end

end
