class Api::LoginController < ApplicationController
  include ApiHelper
  skip_before_filter  :verify_authenticity_token
  before_filter :check_missing_params, :check_params

  def login
    render json: { user: { group_id: @user.group_id, name: @user.name, id: @user.id },
                   token: @user.token, code: 200 },
           status: 200
  end

  private

  def check_missing_params
    missing_params = []

    missing_params << 'email' unless params[:email]
    missing_params << 'password' unless params[:password]

    if missing_params.any?
      bad_request("Parameters missing: #{missing_params.join(', ')}", 200)
    else
      @email = params[:email]
      @password = params[:password]
    end
  end

  def check_params
    @user = User.find_by email: @email

    bad_request('Wrong username', 200) and return unless @user
    bad_request('Wrong password', 200) unless @user.password == Digest::SHA1.hexdigest(@password)
  end
end
