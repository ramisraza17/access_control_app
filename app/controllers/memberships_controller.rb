class MembershipsController < ApplicationController
  include OrganizationAccess
  before_action :set_membership, only: [:update, :destroy]

  def index
    @organization = current_organization
    @memberships = current_organization.memberships.includes(:user)
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user
      @membership = current_organization.memberships.new(user: user, role: 'member')
      
      if @membership.save
        redirect_to organization_memberships_path(current_organization), 
                    notice: 'User added to organization'
      else
        redirect_to organization_memberships_path(current_organization), 
                    alert: @membership.errors.full_messages.to_sentence
      end
    else
      redirect_to organization_memberships_path(current_organization)
    end
  end

  def update
    @membership = current_organization.memberships.find(params[:id])
    
    if @membership.update(membership_params)
      redirect_to organization_memberships_path(current_organization), 
                  notice: 'Role updated successfully'
    else
      redirect_to organization_memberships_path(current_organization), 
                  alert: @membership.errors.full_messages.to_sentence
    end
  end

  def edit
    @organization = current_organization
    @membership = @organization.memberships.find(params[:id])
  end

  def destroy
    @membership.destroy
    redirect_to organization_memberships_path(current_organization), 
                notice: 'Member removed from organization'
  end

  private

  def set_membership
    @membership = current_organization.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:role)
  end
end
