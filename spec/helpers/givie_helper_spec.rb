require 'spec_helper'

describe GivieHelper do
  subject(:generated_url) { helper.givie_url(donation) }
  let(:donation) {
    Donation.new({
      id: 3,
      name: "sara",
      comment: "this is a comment",
      twitter_handle: "st",
      github_handle: "sg",
      email: "sara@regan.com",
      homepage: "http://www.foo.bar"
    })
  }
  before do
    ENV['GIVIE_SECRET'] = "kitten sandwich is a strange project name"
    ENV['GIVIE_BASE_URL'] = "http://givie.com"
  end

  it "matches a givie pingback url" do
    expect(generated_url).to match(/http:\/\/givie.com\/pingback\?data=\w+/)
  end

  it "passes donation info as encrypted param" do
    crypt = ActiveSupport::MessageEncryptor.new(ENV['GIVIE_SECRET'])
    data = crypt.decrypt_and_verify(data_value(generated_url))
    expect(JSON.parse(data).symbolize_keys).to include({
      uid:      donation.id.to_s,
      name:     donation.name,
      message:  donation.comment,
      twitter:  donation.twitter_handle,
      github:   donation.github_handle,
    })
  end

  def data_value(givie_url)
    Rack::Utils.parse_query(URI.parse(givie_url).query)["data"]
  end
end
