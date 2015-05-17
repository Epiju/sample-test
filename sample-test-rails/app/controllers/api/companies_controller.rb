class Api::CompaniesController < ApplicationController
  include ApiHelper
  skip_before_filter  :verify_authenticity_token
  before_filter :check_missing_params, :check_token, :check_user_type, :check_limit_param

  STUDENT_GROUP_ID = 1

  def events
    @events = @user.events.where('start_date >= ?', @from).order(:start_date).offset(@offset).limit(@limit)

    render json: { events: create_events, code: 200 }, status: 200
  end

  private

  def create_events
    @events.map do |event|
      {
        id: event.id,
        name: event.name,
        start_date: event.start_date,
        number_of_attendees: event.attends.count
      }
    end
  end

  def check_missing_params
    missing_params = []

    missing_params << 'from' unless params[:from]
    missing_params << 'token' unless params[:token]

    if missing_params.any?
      bad_request("Parameters missing: #{missing_params.join(', ')}", 400, 500)
    else
      @token = params[:token]
      @from = Time.parse(params[:from])
      @offset = params[:offset].try(:to_i) || 0
      @limit = params[:limit].try(:to_i) || Event.count
    end
  end

  def check_token
    @user = User.find_by token: @token

    bad_request('Bad token', 200, 401) unless @user
  end

  def check_user_type
    bad_request('Bad user type.', 200, 401) if @user.group_id == STUDENT_GROUP_ID
  end

  def check_limit_param
    check_limit(@limit)
  end
end
