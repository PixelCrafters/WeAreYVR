class Type < ActiveRecord::Base
  has_and_belongs_to_many :organizations

  def css_link_class 
    case name
    when "Startups"
      "wr-link-startup"
    when "Investors"
      "wr-link"
    when "Accelerators/Incubators"
      "wr-link-incubator"
    when "Community Enablers"
      "wr-link"
    when "Academic"
      "wr-link"
    when "Government"
      "wr-link"
    when "Media"
      "wr-link"
    when "Service Providers"
      "wr-link-services"
    when "Web Consulting"
      "wr-link-advisor"
    when "Established Companies"
      "wr-link"
    when "Events"
      "wr-link-event"
    end
  end

  def css_icon_class
    case name
    when "Startups"
      "wr-icon-startup"
    when "Investors"
      "wr-icon-startup"
    when "Accelerators/Incubators"
      "wr-icon-incubator"
    when "Community Enablers"
      "wr-icon-startup"
    when "Academic"
      "wr-icon-startup"
    when "Government"
      "wr-icon-federal"
    when "Media"
      "wr-icon-startup"
    when "Service Providers"
      "wr-icon-services"
    when "Web Consulting"
      "wr-icon-advisor"
    when "Established Companies"
      "wr-icon-startup"
    when "Events"
      "wr-icon-startup"
    end
  end

end
