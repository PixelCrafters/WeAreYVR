class Role < ActiveRecord::Base
  has_many :organization_user_roles
  has_many :organizations
  has_many :users

  def css_link_class 
    case name
    when "Employee"
      "wr-link-employee"
    when "Founder"
      "wr-link-founder"
    when "Freelancer/Contractor"
      ""
    when "Board Member"
      ""
    when "Investor"
      "wr-link-investor"
    when "Service Provider"
      ""
    when "Consultant"
      "wr-link-advisor"
    when "Advisor"
      "wr-link-advisor"
    when "Client"
      ""
    when "User"
      ""
    end
  end

end
