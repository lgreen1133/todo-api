class ApplicationController < ActionController::Base
  before_action :authenticated?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from Pundit::NotAuthorizedError do |exception|
        # redirect_to root_url, alert: exception.message
        render json: {success: false, alert: exception.message}
    end 

  protected 
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_in) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  def authenticated?
    authenticate_or_request_with_http_basic do |username,password|
      resource = User.find_by_username(username)
      if resource.valid_password?(password)
        sign_in :user, resource
      end
    end
  end

end
