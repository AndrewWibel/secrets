require 'rails_helper'
RSpec.describe LikesController, type: :controller do
	before do
		user = create_user
		secret = user.secrets.create(content: "oops")
		@like = user.likes.create(user: user, secret: secret) 
	end
	describe 'when not logged in' do
		before do
			session[:user_id] = nil
		end
		it "cannot access likes create" do
			post :create
			expect(response).to redirect_to('/session/new')
		end
		it "cannot access likes delete" do
			delete :delete, id: @like
			expect(response).to redirect_to('/session/new')
		end
	end
	describe 'when signed in as the wrong user' do
		before do
			@wrong_user = create_user 'julius', 'julius@lakers.com'
			session[:user_id] = @wrong_user.id
		end
		pending 'cannot access create' do
			post :create, user: @wrong_user, secret: @secret
			expect(response).to redirect_to("/users/#{@wrong_user.id}")
		end
		pending 'cannot access delete' do
			delete :delete, id: @like
			expect(response).to redirect_to("/users/#{@wrong_user.id}")
		end
	end
end
