module ApplicationHelper
  def format_donation(package)
    html = "<strong>#{number_to_currency(donation.amount_in_dollars)}</strong>"
    html = "#{html} (Package: #{donation.package})" unless donation.package == 'Custom'
    html.html_safe
  end
end
