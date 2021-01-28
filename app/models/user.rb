class User < ActiveRecord::Base
	has_many :schedules

	def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.save!
    end
  end



	# 	User.where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	# 	  user.provider = auth.provider
	# 	  user.uid = auth.uid

	# 	  user.oauth_token = auth.credentials.token
	# 	  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	# 	  user.save
	# 	end
	# end
end
