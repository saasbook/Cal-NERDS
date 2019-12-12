require 'rails_helper'

RSpec.describe User, type: :model do
	describe 'User#from_omniauth' do
		it 'should parse an OmniAuth::AuthHash' do
			auth_hash = OmniAuth::AuthHash.new({
				:provider => "google_oauth2",
				:uid => "12345",
				:info => OmniAuth::AuthHash::InfoHash.new({
					:name => "John Doe",
					:email => "jdoe@berkeley.edu"
			 	})
			})
			User.from_omniauth auth_hash
			user = User.where(email: "jdoe@berkeley.edu")[0]
			expect(User.all).to include(user)
		end
	end
end
