class DonationObserver < ActiveRecord::Observer
  def after_create(donation)
    Pusher['donations'].trigger! 'donation:created', donation: donation.as_json
  end
end

