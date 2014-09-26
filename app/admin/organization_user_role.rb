ActiveAdmin.register OrganizationUserRole do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params do
    permitted = [:organization_id, :user_id, :role_id]
  end

  form do |f|
    f.inputs "Add/Edit Organization" do
      f.input :organization
      f.input :user
      f.input :role
    end
    f.actions
  end

end
