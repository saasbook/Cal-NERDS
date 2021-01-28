Given /the following users exist/ do |users_table|
	# puts users_table
	# fail "being executed"
	users_table.hashes.each do |user|
		User.create(user)
	end
end

Given /^I am logged in as (\w+)$/ do |name|
	user = User.where(name: name)[0]
	OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
		:provider => "google_oauth2",
		:uid => "12345",
		:info => OmniAuth::AuthHash::InfoHash.new({
			:name => user.name,
			:email => user.email
	 	})
	})
	
	# ApplicationController.set_current_user user.id
	visit "/"
	click_link "Log In with Google"
	# steps %{When I follow "Log In with Google"}
end

# Given /^I am signed in with provider "(.*)"$/ do |provider|
#   visit "/auth/#{provider.downcase}"
# end
