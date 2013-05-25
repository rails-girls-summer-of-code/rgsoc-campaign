class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :protect_production

  protected

    def protect_production
      if Rails.env.production?
        authenticate_or_request_with_http_basic do |username, password|
          username == ENV['http_auth_user'] && password == ENV['http_auth_user']
        end
      end
    end
end
