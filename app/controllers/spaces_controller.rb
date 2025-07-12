class SpacesController < ApplicationController
  include OrganizationAccess
  before_action :set_organization, only: [:index, :new, :create, :edit, :show, :update, :destroy, :join]
  before_action :set_space, only: [:show, :edit, :update, :destroy, :join]

  def index
    @spaces = current_organization.spaces
  end

  def new
    @space = current_organization.spaces.new
  end

  def show
  end

  def new
    @space = current_organization.spaces.new
  end

  def create
    @space = current_organization.spaces.new(space_params)

    if @space.save
      redirect_to [current_organization, @space], notice: 'Space was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @space.update(space_params)
      redirect_to [current_organization, @space], notice: 'Space was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @space.destroy
    redirect_to organization_spaces_url(current_organization), notice: 'Space was successfully destroyed.'
  end

  def join
    if @space.age_appropriate?(current_user)
      redirect_to [current_organization, @space], 
                  notice: 'You have successfully joined this space!'
    else
      redirect_to [current_organization, @space], 
                  alert: 'You do not meet the age requirements for this space.'
    end
  end

  private

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    params.require(:space).permit(:name, :description, :min_age, :max_age)
  end

  def set_organization
    @organization = current_organization
  end
end
