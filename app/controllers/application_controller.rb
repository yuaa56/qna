require "application_responder"

class ApplicationController < ActionController::Base
  #include  CanCan::ControllerAdditions 
  include Pundit
  self.responder = ApplicationResponder
  respond_to :html

 protect_from_forgery with: :exception

# rescue_from CanCan::AccessDenied do |exception|
#  redirect_to root_url, alert: exception.message
# end

 rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

def user_not_authorized
  flash[:alert] = "Access denied."
  redirect_to (request.referrer || root_path)
end


# check_authorization #для CanCan
end
