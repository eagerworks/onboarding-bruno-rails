class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :info, :error, :warning

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
