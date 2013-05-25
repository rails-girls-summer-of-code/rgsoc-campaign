module ApplicationHelper
  def format_package(package)
    html = "<strong>#{number_to_currency(donation.package.price_in_dollars)}</strong>"
    unless donation.package.id == :custom
      type = package.subscription? ? 'Subscription' : 'Package'
      html = "#{html} (#{type}: #{package.name})"
    end
    html.html_safe
  end

  def subscription_type(order)
    if order.subscription?
      "#{content_tag(:em, 'per month')} as a recurring payment".html_safe
    else
      "#{content_tag(:em, 'once')}, as a one-off payment".html_safe
    end
  end

  def signed_in?
    # use devise later on?
    false
  end

  # def display_for(package)
  #   if company?
  #     "Display our logo and company pitch. Please submit these separately to contact@travis-ci.org so we can take care of a good design."
  #   else
  #     "List me on the Travis CI crowdfunding page."
  #   end
  # end
end
