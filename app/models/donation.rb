require 'csv'

class Donation < ActiveRecord::Base
  attr_accessible :stripe_card_token, :stripe_customer_id, :package, :amount, :vat_id, :add_vat, :display, :hide,
    :name, :email, :address, :zip, :city, :state, :country, :twitter_handle, :github_handle, :homepage, :comment

  class << self
    def total
      sum(:amount).to_f / 100
    end

    def stats
      { total: connection.select_value('SELECT SUM(amount) FROM donations') }
    end

    def as_csv
      column_names = %w(name email twitter_handle github_handle homepage comment amount)
      CSV.generate do |csv|
        csv << column_names
        where(package: 'Custom').order('created_at').each do |donation|
          values = donation.attributes.values_at(*column_names)
          values[values.size - 1] = '-' unless donation.display?
          csv << values
        end
      end
    end
  end

  def anonymous?
    name.empty?
  end

  def hide
    !display
  end

  def hide=(hide)
    self.display = !hide
  end

  def twitter_handle=(name)
    write_attribute(:twitter_handle, name.to_s.gsub(/^@/, ''))
  end

  def homepage=(url)
    write_attribute(:homepage, url.blank? || url =~ %r{^https?://} ? url : "http://#{url}")
  end

  def gravatar_url
    super || Gravatar.new(email || '').image_url(ssl: true)
  end

  def vat
    raise "cannot calculate VAT without risking rounding issues" unless amount % 100 == 0
    (amount / 100) * 19
  end

  def amount_in_dollars
    (amount.to_f / 100).to_i
  end

  def vat_in_dollars
    vat.to_f / 100
  end

  def amount_with_vat_in_dollars
    (amount + vat).to_f / 100
  end

  def amount_with_vat
    amount + vat
  end

  def save_with_payment!
    stripe_create_customer
    stripe_create_charge
    save!
  end

  # ANONYMOUS  = { name: 'Anonymous', twitter_handle: '', github_handle: '', homepage: '', comment: '' }
  ATTRS_ANONYMOUS     = [:package, :comment, :created_at]
  ATTRS_NON_ANONYMOUS = [:name, :twitter_handle, :github_handle, :homepage, :gravatar_url]

  def as_json(options = {})
    attrs = ATTRS_ANONYMOUS
    attrs = attrs + ATTRS_NON_ANONYMOUS unless anonymous?
    json = super(only: attrs)
    json.update(cc: !!stripe_customer_id)
    json.update(amount: amount_in_dollars) if display?
    json
  end

  private

    def stripe_create_customer
      customer = Stripe::Customer.create(description: name, email: email, card: stripe_card_token)
      # address_line1: address, address_zip: zip, address_state: state, address_country: country)
      self.stripe_customer_id = customer.id
    rescue Stripe::StripeError => e
      logger.error "Stripe error while creating stripe customer: #{e.message} (#{name}, #{email})"
      errors.add :base, "An error occured while trying to charge your credit card: #{e.message}."
      raise e
    end

    def stripe_create_charge
      amount = add_vat? ? amount_with_vat : self.amount
      description = "#{email} (#{[package, self.amount].join(', ')})"
      Stripe::Charge.create(description: description, amount: amount, currency: 'usd', customer: stripe_customer_id)
    rescue Stripe::StripeError => e
      logger.error "Stripe error while creating a stripe charge: #{e.message} (#{description})"
      errors.add :base, "An error occured while trying to charge your credit card: #{e.message}."
      raise e
    end

end
