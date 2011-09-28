class UsersController < ApplicationController
  def index
    if user_signed_in? && current_user.id == 1
      @users = User.all
    else
      redirect_to root_path, :notice=>'you are not authorized to view that. sorry.'
    end
  end

end
