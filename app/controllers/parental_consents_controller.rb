class ParentalConsentsController < ApplicationController
  skip_before_action :authenticate_user

  def new
    @user = User.find_by(consent_token: params[:token])
    redirect_to root_path, alert: 'Invalid consent token' unless @user
  end

  def create
    @user = User.find_by(consent_token: params[:token])
    if @user
      @user.update!(parental_consent: true, consent_token: nil)
      redirect_to root_path, notice: 'Consent granted successfully!'
    else
      redirect_to root_path, alert: 'Invalid consent token'
    end
  end
end
