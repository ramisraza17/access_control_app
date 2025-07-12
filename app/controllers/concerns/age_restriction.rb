module AgeRestriction
  extend ActiveSupport::Concern

  included do
    before_action :verify_age_access
  end

  private

  def verify_age_access
    space = Space.find(params[:id])
    return if space.age_appropriate?(current_user)
    
    redirect_to organization_spaces_path(space.organization),
                alert: "You don't meet the age requirements for this space"
  end
end
