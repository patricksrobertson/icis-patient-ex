require 'httparty'

class ExternalAuthentication
  def initialize(app)
    @app = app
  end

  def call(env)
    token    = env['X-Bearer-Token']
    uid      = env['X-Uid']
    app_name = env['X-App-Name']

    return forbidden unless token && uid && app_name

    response = HTTParty.get "http://icis-identity-example.herokuapp.com/api/v1/verify.json?id=#{uid}&token=#{token}&app_name=#{app_name}"

    case response.code
    when 403
      forbidden
    when 404
      error_code(404, 'Not Found')
    when 500
      error_code(500, 'Server Error')
    when 503
      error_code(503, 'Maintenance')
    when 504
      error_code(504, 'System Down')
    end
  end

  private
  def forbidden
    error_code(403, 'Unauthorized')
  end

  def error_code(code, message)
    [code, {'Content-Type' => 'text/plain'}, [message]]
  end
end
