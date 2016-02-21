FactoryGirl.define do
	factory :user do
		email									'test@example.com'
		password							'mypassword00'
		password_confirmation	'mypassword00'
	end
end
