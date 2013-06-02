class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

    def require_http_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['HTTP_AUTH_USER'] && password == ENV['HTTP_AUTH_PASSWORD']
      end
    end
end
