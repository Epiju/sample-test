module ApiHelper
  def bad_request(json_error, status_code, code)
    render(status: status_code, json: { code: code, message: json_error })
  end

  def check_limit(limit)
    bad_request('Wrong limit.', 400, 500) if limit.present? && limit.to_i <= 0
  end
end