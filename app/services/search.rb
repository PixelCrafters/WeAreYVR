class Search
  include Service

  attr_reader :params, :search_type, :query, :tags, :types, :roles

  def initialize(params, search_type=nil)
    @params = params
    @search_type = search_type
    @query = params[:query] || "*"
    @tags = params[:tags] || nil
    @types = params[:types] || nil
  end

  def call
    if search_type == "organization"
      organizations
    elsif search_type == "user"
      users
    else
      all_results
    end
  end

  private

  def all_results
    organizations + users
  end

  def organizations
    Organization.search(query, conditions).results
  end

  def users
    User.search(query, conditions).results
  end

  def conditions
    query = {}
    order = { order: { updated_at: :desc } }
    
    if tags
      query.merge!(tag_names: {all: tags})
    end
    
    if types
      query.merge!(type_ids: {all: types})
    end

    return {where: query}.merge order
  end
end
