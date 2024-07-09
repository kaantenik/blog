class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Bu sayfayı görmeye yetkili değilsiniz'
    redirect_to(request.referer || root_path)
  end
end
