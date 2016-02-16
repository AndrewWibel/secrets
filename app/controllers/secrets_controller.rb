class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :delete]
	def index
		@secrets = Secret.all
		@likes = Like.all
	end
	def create
	  	user = User.find(current_user)
	  	secret = user.secrets.new(content:params[:new_secret])
	  	secret.save
	  	redirect_to '/users/%d' % session[:user_id]
	end
	def delete
	  	secret = Secret.find(params[:id])
	  	secret.destroy if secret.user == current_user
	  	redirect_to '/users/%d' % session[:user_id]
	end
end
