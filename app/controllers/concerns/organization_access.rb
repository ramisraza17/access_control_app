module OrganizationAccess
  extend ActiveSupport::Concern

  included do
    helper_method :current_membership, :current_organization
  end

  private

  def current_organization
    @current_organization ||= 
      Organization.find_by(id: params[:organization_id]) ||
      Organization.find_by(id: params[:id]) ||
      @organization
  end

  def current_membership
    return unless current_user && current_organization
    @current_membership ||= current_user.memberships.find_by(organization: current_organization)
  end

  def require_organization_membership
    return if current_membership
    redirect_to organizations_path, alert: "You're not a member of this organization"
  end

  def require_role_permission
    action = action_name.to_sym
    return if current_membership&.has_permission?(action)
    
    redirect_to organization_path(current_organization), 
                alert: "You don't have permission for this action"
  end
end
