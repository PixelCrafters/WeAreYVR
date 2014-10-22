class Job < ActiveRecord::Base
  validates :organization, presence: true
  validates :title, presence: true
  validates :job_type, presence: true
  validates :link, presence: true


  scope :sponsored, ->    { where(sponsored: true) }
  scope :nonsponsored, -> { where(sponsored: false) }
  scope :published, ->    { where(published: true) }
  scope :last_month, ->   { where(['created_at > ?', 1.month.ago]) }
  
  searchkick
  acts_as_paranoid
  
  belongs_to :organization
  def search_data
    {
      title: title,
      description: description,
      job_type: job_type,
      level: level
    }
  end

  def levels_wanted
    result = []
    if self.want_junior
      result << "Junior"
    end
    if self.want_intermediate
      result << "Intermediate"
    end
    if self.want_senior
      result << "Senior"
    end
    if self.want_executive
      result << "Executive"
    end
    return result.join(", ")
  end

end
