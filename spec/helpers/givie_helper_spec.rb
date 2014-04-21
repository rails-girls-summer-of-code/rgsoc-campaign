require 'spec_helper'

describe GivieHelper do

  it "generates a givie url from a donation" do
    donation = Donation.new({
      id: 3,
      name: "sara", 
      comment: "this is a comment", 
      twitter_handle: "st", 
      github_handle: "sg", 
      email: "sara@regan.com",
      homepage: "http://www.foo.bar"})
    expect(helper.givie_url(donation)).to eq("http://kitten-sandwich.herokuapp.com/pingback?name=sara&message=this is a comment&twitter=st&github=sg&gravatar=#{donation.gravatar_url}&homepage=http://www.foo.bar&uid=#{donation.id}")
  end
  
end