# frozen_string_literal: true

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (requires ORM extensions installed).
  # Check the list of supported ORMs here: https://github.com/doorkeeper-gem/doorkeeper#orms
  orm :active_record
  # skip_client_authentication_for_password_grant:  true
  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end
  admin_authenticator do |_routes|
    #current_user || warden.authenticate!(scope: :user)
    #Admin.find_by_id(session[:admin_id]) || redirect_to(new_admin_session_url)
    current_user.try(:admin)  || redirect_to(new_user_session_path)
  end


  default_scopes :read
  optional_scopes :write
      
  enforce_configured_scopes

  # !!! Authorization Code expiration time (default 10 minutes).
  authorization_code_expires_in 60.minutes

  # Access token expiration time (default 12 hours).
  # !!! If you want to disable expiration, set this to nil.
   access_token_expires_in 12.hours


end
