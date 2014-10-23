require 'digest/md5'

class User < ActiveRecord::Base
  include PublicActivity::Common

  searchkick
  acts_as_taggable

  has_many :organization_user_roles
  has_many :user_auth_services
  has_and_belongs_to_many :organizations
  has_many :profile_links, :as => :linkable
  has_many :roles, through: :organization_user_roles

  def search_data
    {
      name: name,
      updated_at: updated_at,
      tag_names: tags.map(&:name)
    }
  end

  def image_fallback
    if self.image.blank?
      email_address = self.email.blank? ? '' : self.email.downcase
      hash = Digest::MD5.hexdigest(email_address)
      "http://www.gravatar.com/avatar/#{hash}"
    else
      self.image
    end
  end

  def uid(connection)
    user_auth_services.where(service_type: connection).first!.uid
  end
  
  def current_roles(organization)
    organization_user_roles.where(organization: organization)
  end

  def access_token
    User.create_access_token(self)
  end

  def self.verifier
    ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
  end

  def self.read_access_token(signature)
    id = verifier.verify(signature)
    User.find(id)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  def self.create_access_token(user)
    verifier.generate(user.id)
  end

  def is_admin?(organization)
    id == organization.admin_id
  end
end
