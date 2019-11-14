Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"], {
    redirect_uri: "https://damp-brushlands-79654.herokuapp.com/auth/google_oauth2/callback",
    skip_jwt: true,
    :provider_ignores_state => true
  }
end