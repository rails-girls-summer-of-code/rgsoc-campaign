class RatingsController < ApplicationController
  before_filter :require_http_auth
  before_filter :normalize_data

  layout 'simple'

  def create
    session[:user_name] = params[:rating][:user_name] if params[:rating][:user_name]
    rating = find_or_initialize_rating
    rating.update_attributes(params[:rating])
    redirect_to rating.application
  end

  def update
    rating = Rating.find(params[:id])
    rating.update_attributes(params[:rating])
    redirect_to rating.application
  end

  private

    def normalize_data
      data = params[:rating][:data]
      data.each { |key, value| data[key] = value.to_i if value }
    end

    def find_or_initialize_rating
      attrs = { application_id: params[:rating][:application_id], user_name: session[:user_name] }
      Rating.where(attrs).first || Rating.new(attrs)
    end
end

