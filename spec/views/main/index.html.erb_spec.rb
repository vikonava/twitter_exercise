require 'rails_helper'

RSpec.describe "main/index.html.erb", type: :view do
	context 'user not logged' do
		it 'should contain login and register links' do
			visit root_url
			expect(page.body).to have_link('Log In', href: new_user_session_path)
			expect(page.body).to have_link('Register', href: new_user_registration_path)
		end
	end

	context 'user logged in' do
		before :each do
			user = FactoryGirl.create(:user)
			visit new_user_session_path
			fill_in 'user_email', with: user.email
			fill_in 'user_password', with: user.password
			click_button 'Log in'
		end

		it 'should be able to get BarackObama timeline', js: true do
			expect(page.body).to have_field('screen_name')
			expect(page.body).to have_button('Get Timeline')
			fill_in('screen_name', with: 'BarackObama')
			click_button('Get Timeline')
			expect(page.body).to have_selector('table tbody#result tr', minimum: 1)
		end
	end
end
