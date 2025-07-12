class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      if @user.minor? && @user.parent_email.present?
        @user.update(consent_token: SecureRandom.hex(20))
        ParentalConsentMailer.consent_request(@user).deliver_later
      end
      
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, 
                                 :full_name, :date_of_birth, :parent_email)
  end
end
