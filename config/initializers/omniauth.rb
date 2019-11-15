Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.production?
		redirect_uri = "https://damp-brushlands-79654.herokuapp.com/auth/google_oauth2/callback"
	elsif Rails.env.test?
		redirect_uri = "/auth/google_oauth2/callback"
	else
		redirect_uri = "http://localhost:3000/auth/google_oauth2/callback"
	end
  provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"], {
    redirect_uri: redirect_uri,
    skip_jwt: true,
    :provider_ignores_state => true
  }
end