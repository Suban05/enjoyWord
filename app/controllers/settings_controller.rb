class SettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
  end

  def create
    user = current_user
    if user.update_columns(settings_params.to_h)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def settings_params
    params.permit(:email, :name, :favourite_language)
  end
end
