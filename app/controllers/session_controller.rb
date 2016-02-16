class SessionController < ApplicationController
  def new
  end

  def login
  	@user = User.find_by_email(params["user"][:email])
  	if @user && @user.authenticate(params["user"][:password])
      session[:user_id] = @user.id
  		redirect_to '/users/%d' % session[:user_id]
  	else
  		flash[:message] = 'Invalid Password'
  		redirect_to '/session/new'
  	end
  end

  def logout
    session.clear
    redirect_to '/session/new'
  end
end
