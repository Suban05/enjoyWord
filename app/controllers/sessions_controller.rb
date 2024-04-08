class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    respond_to do |format|
      if user && user.authenticate(params[:password])
        login(user)
        format.html { redirect_to root_path }
      else
        flash[:alert] = t("invalid_credentials")
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
