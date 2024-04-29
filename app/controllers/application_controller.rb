class ApplicationController < ActionController::Base
  include Authentication
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
end
