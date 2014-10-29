class StoreAuthorizedUser
  include Service

  attr_reader :userinfo, :claimed_user

  def initialize(userinfo, claimed_user=nil)
    @userinfo = userinfo
    @claimed_user = claimed_user
  end

  def call
    attributes = {
      email: userinfo["info"]["email"],
      email_verified: userinfo["extra"]["raw_info"]["email_verified"]
    }
    user = ""
    if claimed_user.present?
      user = User.find(claimed_user)
      user.assign_attributes attributes
      user.remote_image_url = userinfo["info"]["image"]
    else
      user = User.new
      user.assign_attributes attributes
      user.name = userinfo["info"]["name"]
      user.claimed = true
      user.remote_image_url = userinfo["info"]["image"]
    end
    user.save!
    user.create_activity key: "user.create", owner: user
    user
  end
end   
