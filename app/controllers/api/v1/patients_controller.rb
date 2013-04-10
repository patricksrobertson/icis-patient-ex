module Api::V1
  class PatientsController < ApiController
    before_filter :authorize

    def show
      patient = Patient.find_by_uid(params[:id])

      render json: patient
    end

    def index
      patients = Patient.all

      render json: patients
    end

    private
    def authorize
      render text: 'unauthorized', status: 401 unless access_token && uid && app_name

      uri = URI.parse("http://icis-identity-example.herokuapp.com/api/v1/verify/#{uid}")

      get_parameters = {
        token: access_token,
        app_name: app_name
      }

      req                 = Net::HTTP::Get.new(uri.path)
      req.body            = JSON.generate(get_parameters)
      req["Content-Type"] = "application/json"

      http = Net::HTTP.new(uri.host, uri.port)
      resp = http.start { |ht| ht.request(req) }
    end

    def access_token
      @access_token ||= request.headers['X-Bearer-Token']
    end

    def uid
      @uid ||= request.headers['X-Uid']
    end

    def app_name
      @app_name ||= request.headers['X-App-Name']
    end
  end
end
