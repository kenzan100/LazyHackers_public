class OmniauthCallbacksController < ApplicationController
  def twitter
    # You need to implement the method below in your model
    @user = User.find_for_user_oauth(env["omniauth.auth"],nil)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "User"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_data"] = env["omniauth.auth"]
      redirect_to root_path
    end
  end

end
