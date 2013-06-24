class CoachesController < ApplicationController
  before_filter :require_http_auth

  layout 'simple'

  def index
    @applications = Application.order(:id)
  end
end
