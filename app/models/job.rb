class Job < ActiveRecord::Base
  scope :sponsored, -> { where(sponsored: true) }
  scope :nonsponsored, -> { where(sponsored: false) }
  searchkick
  belongs_to :organization
  def search_data
    {
      title: title,
      description: description,
      job_type: job_type,
      level: level
    }
  end
end
