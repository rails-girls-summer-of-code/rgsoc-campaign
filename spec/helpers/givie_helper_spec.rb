require 'spec_helper'

describe GivieHelper do
  subject { helper.encrypted_givie_params(donation) }
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
  end

  it "passes donation info as encrypted param" do
    crypt = ActiveSupport::MessageEncryptor.new(ENV['GIVIE_SECRET'])
    data = crypt.decrypt_and_verify(subject)
    expect(JSON.parse(data).symbolize_keys).to include({
      uid:      donation.id.to_s,
      name:     donation.name,
      message:  donation.comment,
      twitter:  donation.twitter_handle,
      github:   donation.github_handle,
    })
  end
end
