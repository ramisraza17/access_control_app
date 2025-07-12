class OrganizationsController < ApplicationController
  include OrganizationAccess

  before_action :authenticate_user
  before_action :set_organization, only: [:show, :edit, :update, :destroy, :dashboard]
  before_action :require_owner, only: [:edit, :update, :destroy]

  def index
    @organizations = current_user.organizations
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    
    if @organization.save
      current_user.memberships.create(organization: @organization, role: 'owner')
      redirect_to @organization, notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: 'Organization was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_url, notice: 'Organization was successfully destroyed.'
  end

  def dashboard
    @current_membership = current_user.memberships.find_by(organization: @organization)
    @spaces = @organization.spaces
    @memberships = @organization.memberships.includes(:user)
    
    unless @current_membership
      redirect_to organization_path(@organization), alert: "You're not a member of this organization"
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :description, participation_rules: {})
  end

  def require_owner
    membership = current_user.memberships.find_by(organization: @organization)
    unless membership&.role == 'owner'
      redirect_to organizations_path, alert: "You must be the owner to perform this action."
    end
  end
end
