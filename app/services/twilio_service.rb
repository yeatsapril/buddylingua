require 'twilio-ruby'
class TwilioService


  def generate_token(match, user)
    # Required for any Twilio Access Token
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    api_key = ENV['TWILIO_API_KEY']
    api_secret = ENV['TWILIO_API_SECRET']

    identity = "user-#{user.id}"

    # Create an Access Token
    token = Twilio::JWT::AccessToken.new(account_sid, api_key, api_secret, [], identity: identity)

    # Create Video grant for our token
    grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = "video-#{match.id}"
    token.add_grant(grant)

    # Generate the token
    return token.to_jwt
  end

end
