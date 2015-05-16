class Api::UsersController < ApplicationController
  include ApiHelper
  skip_before_filter  :verify_authenticity_token
  before_filter :check_missing_events_params, :check_events_params, only: [:events]
  before_filter :check_missing_reserve_params, :check_reserve_params, only: [:reserve]

  STUDENT_GROUP_ID = 1
  COMPANY_GROUP_ID = 2

  def events
    @events = Event.where('start_date >= ?', @from).order(:start_date).offset(@offset).limit(@limit)

    render json: { events: create_events, code: 200 },
           status: 200
  end

  def reserve
    render(status: 200, json: { code: 401, message: 'Token is missing.' })
  end

  private

  def check_missing_events_params
    missing_params = []

    missing_params << 'from' unless params[:from]
    if missing_params.any?
      bad_request("Parameters missing: #{missing_params.join(', ')}", 400)
    else
      @from = Time.parse(params[:from])
      @offset = params[:offset].try(:to_i) || 0
      @limit = params[:limit].try(:to_i) || Event.count
    end
  end

  def check_events_params
    bad_request('Wrong limit.', 400) if @limit.present? && @limit.to_i <= 0
  end

  def create_events
    @events.map do |event|
      {
          id: event.id,
          name: event.name,
          start_date: event.start_date,
          company: {
              id: event.user.id,
              name: event.user.name
          }
      }
    end
  end

  def check_missing_reserve_params
    unless params[:token].present?
      render(status: 200, json: { code: 401, message: 'Token is missing.' })
    end

    @token = params[:token]
    @event_id = params[:event_id]
    @reserve = params[:reserve]
  end

  def check_reserve_params
    user = User.find_by token: @token
    render(status: 200, json: { code: 401, message: 'Bad token.' }) and return unless user

    if user.group_id == COMPANY_GROUP_ID
      render(status: 200, json: { code: 401, message: 'Token is missing.' })
    end
  end
end

