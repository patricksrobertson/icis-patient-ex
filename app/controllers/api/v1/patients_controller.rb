module Api::V1
  class PatientsController < ApiController
    def show
      patient = Patient.find_by_uid(params[:id])

      render json: patient
    end

    def index
      patients = Patient.all

      render json: patients
    end
end
