module GivieHelper
  
  def givie_url(donation)
    "http://kitten-sandwich.herokuapp.com/pingback?" + 
      "name=#{donation.name}" +
      "&message=#{donation.comment}" + 
      "&twitter=#{donation.twitter_handle}" + 
      "&github=#{donation.github_handle}" +
      "&gravatar=#{donation.gravatar_url}" +
      "&homepage=#{donation.homepage}" +
      "&uid=#{donation.id}"
  end
  
end
