class Organization < ActiveRecord::Base
  include PublicActivity::Common

  mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  searchkick
  acts_as_taggable

  has_many :organization_user_roles
  has_many :addresses
  has_many :profile_links, :as => :linkable
  has_many :roles
  has_and_belongs_to_many :users
  has_and_belongs_to_many :types
  has_many :jobs

  def admin_id=(value)
    if !admin_id.nil?
      write_attribute(:claimed, true) 
    else
      write_attribute(:claimed, false) 
    end
    ###
    write_attribute(:admin_id, value)
    # this is same as self[:attribute_name] = value
  end

  def search_data
    {
      name: name,
      updated_at: updated_at,
      type_ids: types.pluck(:id),
      tag_names: tags.pluck(:name)
    }
  end

  # temporary addition. will be replaced by 'main_address' once we acquire what the main address is from a person
  def main_address
    addresses.first
  end

  def updated_last_24_hours?
    updated_at > Time.now - 24.hours
  end

  def created_last_24_hours?
    created_at > Time.now - 24.hours
  end

  def years_in_business
    # Difference in years, less one if you have not had a birthday this year.
    if founded.nil?
      ""
    else
      now = DateTime.now
      years = now.year - founded.year
      years = years - 1 if (
           founded.month >  now.month or 
          (founded.month >= now.month and founded.day > now.day)
      )
      if years < 1
        "Less than a year"
      else
        years
      end
    end
  end

  def css_neighbourhood_icon_class
    case neighbourhood
    when "Downtown"
      "wr-icon-downtown"
    when "East Van"
      "wr-icon-eastvan"
    when "Gastown"
      "wr-icon-gastown"
    when "Mount Pleasant"
      "wr-icon-mount-pleasant"
    end
  end

end
