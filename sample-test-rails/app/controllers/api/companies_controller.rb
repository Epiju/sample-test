class Api::CompaniesController < ApplicationController
  include ApiHelper
  skip_before_filter  :verify_authenticity_token
  before_filter :check_missing_params, :check_token, :check_user_type, :check_limit

  STUDENT_GROUP_ID = 1

  def events
    @events = @user.events.where('start_date >= ?', @from).order(:start_date).offset(@offset).limit(@limit)

    render json: { events: create_events, code: 200 },
           status: 200
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
      render(status: 400, json: { message: 'Bad params.' })
    else
      @token = params[:token]
      @from = Time.parse(params[:from])
      @offset = params[:offset].try(:to_i) || 0
      @limit = params[:limit].try(:to_i) || Event.count
    end
  end

  def check_token
    @user = User.find_by token: @token
    render(status: 200, json: { code: 401, message: 'Bad token.' }) unless @user
  end

  def check_user_type
    if @user.group_id == STUDENT_GROUP_ID
      render(status: 200, json: { code: 401, message: 'Bad user type.' })
    end
  end

  def check_limit
    bad_request('Wrong limit.', 400) if @limit.present? && @limit.to_i <= 0
  end
end
