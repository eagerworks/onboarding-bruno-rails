class UsersController < ApplicationController
  layout 'application'
  def show
    @user = current_user
  end
end
