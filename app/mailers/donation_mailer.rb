class DonationMailer < ActionMailer::Base
  # include ApplicationHelper
  # helper_method :encoded_image

  # layout 'email'
  # default from: 'Travis CI <contact@travis-ci.org>',
  #         bcc:  'Travis CI <contact@travis-ci.org>'

  attr_reader :donation
  helper_method :donation

  def confirmation(donation)
    @donation = donation
    mail(:to => donation.user.email, :subject => 'Thank you for supporting RailsGirls Summer of Code!')
  end
end

