class OrganizationUserRole < ActiveRecord::Base
  belongs_to :organization
  belongs_to :role
  belongs_to :user

  def name
    if !role.nil?
      role.name  
    else
      ""
    end
  end

  def css_link_class
    if !role.nil?
      role.css_link_class
    else
      ""
    end
  end

end
