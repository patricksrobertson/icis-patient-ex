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
      render text: 'Unauthorized', status: 403 unless access_token && uid && app_name

      response = HTTParty.get "http://icis-identity-example.herokuapp.com/api/v1/verify/#{uid}.json?token=#{access_token}&app_name=#{app_name}"

      case response.code
      when 403
        render text: 'Unauthorized', status: 403
      when 404
        render text: 'Not Found', status: 404
      when 500
        render text: 'Server Error', status: 500
      when 503
        render text: 'Maintenance', status: 503
      when 504
        render text: 'System Down', status: 504
      end
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
