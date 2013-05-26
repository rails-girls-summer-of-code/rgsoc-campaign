class DonationsController < ApplicationController
  force_ssl except: [:index, :stats]
  before_filter :normalize_params, only: [:checkout, :create]

  def index
    render json: Donation.order('created_at DESC').as_json
  end

  def stats
    render json: Donation.stats
  end

  def create
    if donation.valid?
      donation.save_with_payment!
      # send_confirmation
      redirect_to confirm_donation_url(donation)
    else
      render :checkout
    end
  rescue Stripe::StripeError => e
    return render :checkout
  end

  def show
    render :confirm_creation
  end

  def confirm
    render :confirm_creation
  end

  protected

    helper_method :donation, :company?, :needs_vat?

    # def send_confirmation
    #   DonationMailer.confirmation(donation).deliver
    # end

    def donation
      @donation ||= params[:id] ? Donation.find(params[:id]) : Donation.new(params[:donation])
    end

    def company?
      params[:package] != 'Custom'
    end

    def needs_vat?
      company?
    end

    def normalize_params
      params[:amount] = params[:amount].to_i if params[:amount]
      params[:donation] ||= { package: params[:package] || 'tiny', amount: params[:amount] }
      params[:donation][:stripe_card_token] ||= params[:stripe_card_token]
    end
end
