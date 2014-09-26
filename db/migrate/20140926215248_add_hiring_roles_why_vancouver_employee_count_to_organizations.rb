class AddHiringRolesWhyVancouverEmployeeCountToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :hiring_roles, :string
    add_column :organizations, :why_vancouver, :string
    add_column :organizations, :number_of_employees, :integer
  end
end
