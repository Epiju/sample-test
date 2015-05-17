module ApiHelper
  STUDENT_GROUP_ID = 1
  COMPANY_GROUP_ID = 2

  def bad_request(json_error, status_code, code)
    render(status: status_code, json: { code: code, message: json_error })
  end

  def check_token
    @user = User.find_by token: @token
    bad_request('Bad token', 200, 401) unless @user
  end

  def check_user_type
    if (params[:controller] == 'api/users' && @user.group_id != STUDENT_GROUP_ID) ||
        (params[:controller] == 'api/companies' && @user.group_id != COMPANY_GROUP_ID)
      bad_request('Bad user type.', 200, 401)
    end
  end

  def check_limit_param
    bad_request('Wrong limit.', 400, 500) if @limit.present? && @limit.to_i <= 0
  end
end