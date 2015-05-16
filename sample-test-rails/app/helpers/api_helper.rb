module ApiHelper
  def bad_request(json_error, code)
    render(status: code, json: { code: 500, message: json_error })
  end
end