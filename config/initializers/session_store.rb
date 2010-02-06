# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_seanchai_session',
  :secret      => '50a962f42643e696024feca33d176103d52959d0eccedb80925fe9fc16f23c293a65f978fcfd92ee4f7df5784816b7f70c411d64846cab9c879135b0f9d9cac1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
