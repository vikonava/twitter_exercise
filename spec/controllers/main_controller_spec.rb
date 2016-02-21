require 'rails_helper'

RSpec.describe MainController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

	describe "GET #timeline" do
		context "with user logged in" do
			login_user

			it "returns http success" do
				get :timeline, { screen_name: 'BarackObama' }
				expect(response).to have_http_status(200)
			end
		end

		context "with guest not logged in" do
			it "returns access denied" do
				get :timeline, { screen_name: 'BarackObama' }
				expect(response).to have_http_status(403)
			end
		end
	end
end
