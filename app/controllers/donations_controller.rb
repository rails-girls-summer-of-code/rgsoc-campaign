class DonationsController < ApplicationController
  before_filter :normalize_params,   only: [:new, :create]
  # before_filter :authenticate_user!, only: [:show, :destroy]
  # before_filter :guard_duplicate_subscription, only: [:new, :create]
  # before_filter :validate_logged_in, only: [:confirm]

  def index
    render json: Donation.includes(:user).includes(:address).order('created_at DESC').as_json
  end

  def stats
    render json: Donation.stats
  end

  def show
    render :confirm_creation
  end

  def create
    if donation.valid? && user.valid?
      begin
        user.save_with_customer!
        # sign_in user
        donation.save_with_payment!
      rescue Stripe::StripeError => e
        Rails.logger.error("Error: #{e.message}")
        donation.errors.add(:base, "An error occured while trying to charge your credit card: #{e.message}.")
        return render :new
      end
      # send_confirmation
      redirect_to confirm_donation_url(donation)
    else
      render :new
    end
  end

  def confirm
    render :confirm_creation
  end

  # def destroy
  #   donation.cancel!
  #   redirect_to profile_url
  # end

  protected

    helper_method :user, :donation, :address, :address, :subscription?, :company?, :needs_vat?
    delegate :address, :address, to: :donation

    def send_confirmation
      DonationMailer.confirmation(donation).deliver
    end

    def user
      # @user ||= current_user || User.new(params[:user])
      @user ||= User.new(params[:user])
    end

    def donation
      @donation ||= params[:id] ? Donation.find(params[:id]) : user.donations.build(params[:donation])
    end

    def address
      @address ||= donation.address
    end

    def subscription?
      !!params[:subscription]
    end

    def company?
      %w(silver gold platinum).include?(params[:package])
    end

    def needs_vat?
      company? # or params[:package] == 'huge' or params[:package] == 'big' && !subscription?
    end

    # def subscribed?
    #   signed_in? && current_user.subscriptions.active.any?
    # end

    def normalize_params
      params[:amount] = params[:amount].to_i * 100 if params[:amount]
      params[:donation] ||= { package: params[:package] || 'tiny', amount: params[:amount], subscription: subscription? }
      params[:donation][:address_attributes] ||= {}
      # params[:donation][:address_attributes] ||= { name: user.name }
      params[:user]  ||= {}
      params[:user][:company] = company?
      params[:user][:stripe_card_token] ||= params[:stripe_card_token]
    end

    # def guard_duplicate_subscription
    #   render :duplicate_subscription if subscription? && subscribed?
    # end

    # def validate_logged_in
    #   redirect_to root_url if current_user.nil?
    # end
end
