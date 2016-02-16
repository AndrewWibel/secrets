class LikesController < ApplicationController
	before_action :require_login, only: [:create, :delete]
	# before_action :require_correct_user, only: [:create, :delete]
	def create
		secret = Secret.find(params['secret_id'])
		Like.create(user:current_user, secret: secret)
		redirect_to '/secrets'
	end
	def delete
		like = Like.where('user_id = ? AND secret_id = ?', current_user, params[:id])[0]
		like.destroy		
		redirect_to '/secrets'
	end
end