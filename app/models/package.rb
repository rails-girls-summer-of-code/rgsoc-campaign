# Need to add these plans to Stripe, either using the Stripe management interface
# or using the api. See https://stripe.com/docs/tutorials/subscriptions

class Package
  PACKAGES      = { nano: 100, tiny: 1000, small: 3500, medium: 7000, big: 20000, huge: 50000, bronze: 100000, silver: 500000, gold: 1000000, platinum: 1500000 }
  SUBSCRIPTIONS = { small: 1000, medium: 1500, big: 2500 }

  class << self
    def price(package, subscription = false)
      (subscription ? SUBSCRIPTIONS : PACKAGES)[package.to_sym] / 100
    end
  end

  attr_reader :id, :subscription

  def initialize(id, amount, subscription)
    @id = id.to_sym
    @price = amount
    @subscription = subscription
    raise "invalid package: #{id}" unless id.to_sym == :custom || PACKAGES.key?(id.to_sym)
  end

  def company?
    [:bronze, :silver, :gold, :platinum].include?(id)
  end

  def subscription?
    !!subscription
  end

  def name
    id.to_s.camelize
  end

  def price
    @price ||= (subscription? ? SUBSCRIPTIONS[id] : PACKAGES[id])
  end

  def price_in_dollars
    price.to_f / 100
  end

  def vat
    raise "cannot calculate VAT without risking rounding issues" unless price % 100 == 0
    (price / 100) * 19
  end

  def vat_in_dollars
    vat.to_f / 100
  end

  def price_with_vat_in_dollars
    (price + vat).to_f / 100
  end

  def price_with_vat
    price + vat
  end

  def sort_order
    PACKAGES.keys.index(id)
  end
end

