class Donation < ActiveRecord::Base
  belongs_to :user
  has_one :address

  attr_accessible :stripe_token, :stripe_id, :package, :amount, :subscription, :comment, :message,
    :vat_id, :add_vat, :address_attributes

  accepts_nested_attributes_for :user, :address

  validates_presence_of :package

  before_validation do
    self.amount = package.price unless read_attribute(:amount)
  end

  class << self
    def total
      sum(:amount).to_f / 100
    end

    def active
      where(active: true)
    end

    def stats
      stats = Hash[*connection.select_rows('SELECT package, count(id) FROM orders GROUP BY package').flatten].symbolize_keys
      stats.each { |key, value| stats[key] = value.to_i }
    end
  end

  attr_accessor :card_number

  def package
    @package ||= Package.new(read_attribute(:package), read_attribute(:amount), subscription?)
  end

  def amount
    read_attribute(:amount) || package.price
  end

  def amount_in_dollars
    amount.to_f / 100
  end

  def cancelled?
    !active?
  end

  def cancel!
    update_attributes!(active: false, cancelled_at: Time.now)
    user.cancel_subscription
  end

  def save_with_payment!
    subscription? ? user.subscribe(self) : user.charge(self)
    save!
  end

  JSON_ATTRS = [:subscription, :created_at, :comment]

  def as_json(options = {})
    super(only: JSON_ATTRS).merge(amount: amount_in_dollars, user: user.as_json, package: read_attribute(:package))
  end
end
