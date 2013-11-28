class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :winningbid
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit! }
  end

  def winningbid
       servicerequest = Servicerequest.where("id = ?",params[:id])
       servicerequest.provider_id = params[:provider_id]
       servicerequest.status = 'Accepted'
       servicerequest.save
       redirect_to servicerequest_path
   end

end
