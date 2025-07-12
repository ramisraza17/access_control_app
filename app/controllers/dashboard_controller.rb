class DashboardController < ApplicationController
  before_action :authenticate_user

  def index
    @organizations = current_user.organizations
    @spaces = Space.joins(:organization)
                   .where(organizations: { id: @organizations.pluck(:id) })
                   .limit(5)
  end
end
