class Api::V1::ProfilesController < Api::V1::BaseController

  def me
    respond_with current_resource_owner
  end

  def index
    @profiles = User.where.not(id: doorkeeper_token.resource_owner_id)
    #puts '+++++++++++++'
    #@profiles.each { |att|  puts(att.email) }
    respond_with @profiles
  end

end