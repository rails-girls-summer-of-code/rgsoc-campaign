module ApplicationHelper
  def link_to_ordered(text, type)
    # link_to text, applications_path(order: type), class: order.to_sym == type ? 'active' : ''
    if order.to_sym == type
      content_tag :span, text, class: 'active'
    else
      link_to text, applications_path(order: type)
    end
  end

  def format_donation(package)
    html = "<strong>#{number_to_currency(donation.amount_in_dollars)}</strong>"
    html = "#{html} (Package: #{donation.package})" unless donation.package == 'Custom'
    html.html_safe
  end
end
