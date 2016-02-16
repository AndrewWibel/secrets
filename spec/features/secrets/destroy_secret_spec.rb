require 'rails_helper'
RSpec.describe 'deleting a secret' do
	before do
		@user = create_user
		log_in @user
		fill_in 'new_secret', with: 'My Secret'
		click_button 'Create Secret'
		expect(page).to have_text('My Secret')
	end
	it 'deletes secrets from profile page and redirects to profile page' do
		click_button 'Delete'
		expect(current_path).to eq("/users/#{@user.id}")
		expect(page).not_to have_text('My Secret')
	end
	it 'deletes secret from secrets index page and redirects to current user profile page' do
		visit '/secrets'
		click_button 'Delete'
		expect(current_path).to eq("/users/#{@user.id}")
		expect(page).not_to have_text('My Secret')
	end
end		