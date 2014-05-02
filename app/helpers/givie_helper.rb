module GivieHelper

  def givie_url(donation)
    crypt = ActiveSupport::MessageEncryptor.new(ENV['GIVIE_SECRET'])
    data = crypt.encrypt_and_sign({
      uid: donation.id.to_s,
      name: donation.name,
      message: donation.comment,
      twitter: donation.twitter_handle,
      github: donation.github_handle,
      gravatar: donation.gravatar_url,
      homepage: donation.homepage,
    }.to_json)

    "#{ENV['GIVIE_BASE_URL']}/pingback?data=" + data
  end
end
