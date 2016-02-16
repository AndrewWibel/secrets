class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :delete]
	def show
		@user = User.find(session[:user_id])
		@secrets = @user.secrets
	end	
	def new
	end
	def create
		@user_new = User.new(new_user_params)
		if @user_new.valid? == true
			@user_new.save
			session[:user_id] = @user_new.id
			redirect_to '/users/%d' % session[:user_id]
		else
			flash[:messages] = @user_new.errors.full_messages
			redirect_to '/users/new'
		end
	end
	def edit
		@user = User.find(session[:user_id])
	end
	def update
		user = User.find(session[:user_id])
		user.update_attributes(update_user_params)
		redirect_to '/users/%d' % session[:user_id]
	end
	def delete
		current_user.destroy
		session.clear
		redirect_to '/session/new'
	end
	private
	def new_user_params
		params.require(:newuser).permit(:name, :email, :password)
	end
	def update_user_params
		params.require(:update).permit(:name, :email, :password)
	end

end
