class ProfileLink::Activity::Store
  include Service

  attr_reader :profile_link, :current_user, :type

  def initialize(profile_link, current_user, type)
    @profile_link = profile_link
    @current_user = current_user
    @type = type
  end

  def call
    profile_link.create_activity(
        key: "profile_link.#{type}", 
        owner: current_user, 
        parameters: {
          name: profile_link.name,
          url: profile_link.url,
          linkable_name: "aa yeah",
          linkable_type: profile_link.linkable_type,
          linkable: profile_link.linkable,
          cool: profile_link
        }
      )
  end
end
