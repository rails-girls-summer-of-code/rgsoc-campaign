require 'applications/table'

class ApplicationsController < ApplicationController
  before_filter :require_http_auth
  before_filter :normalize_params, only: :update
  before_filter :persist_order

  # layout 'simple'
  layout false

  def index
    @applications = applications_table
  end

  def show
    @application = Application.find(params[:id])
    @rating = find_or_initialize_rating
    @data = @rating.data
    @prev = prev_application
    @next = next_application
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    application.update_attributes!(params[:application])
    redirect_to application
  end

  private

    def order
      params[:order] || session[:order] || :id
    end
    helper_method :order

    def persist_order
      session[:order] = :mean if session[:order] == 'total_rating'
      session[:order] = params[:order] if params[:order]
    end

    def exclude
      (params[:exclude] || session[:exclude] || '').split(',').map(&:strip)
    end

    def applications
      @applications = Application.includes(:ratings).visible.sort_by(order)
    end

    def applications_table
      Applications::Table.new(Rating.user_names, applications, exclude: exclude)
    end

    def find_or_initialize_rating
      attrs = { application_id: @application.id, user_name: session[:user_name] }
      Rating.where(attrs).first || Rating.new(attrs.merge(data: Hashr.new(@application.rating_defaults)))
    end

    def normalize_params
      params[:application][:sponsor_pick] = '' if params[:application][:sponsor_pick].blank?
      params[:application][:data] = params[:application][:data].inject({}) do |data, (key, value)|
        value = nil if value == ''
        data.merge(CGI.unescape(key) => value)
      end
    end

    def prev_application
      all = applications
      all = all.reverse if [:mean, :median, :weighted, :truncated].include?(order)
      ix = all.index { |a| a.id == params[:id].to_i }
      all[ix - 1]
    end

    def next_application
      all = applications
      all = all.reverse if [:mean, :median, :weighted, :truncated].include?(order)
      ix = all.index { |a| a.id == params[:id].to_i }
      all[ix + 1]
    end
end
