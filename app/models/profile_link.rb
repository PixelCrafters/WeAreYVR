class ProfileLink < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :linkable, :polymorphic => true

  before_save :add_url_protocol

  protected

  def add_url_protocol
    if !self.url.blank?
      unless self.url[/\Ahttps?:\/\//]
        self.url = "http://#{self.url}"
      end  
    end
  end
end
