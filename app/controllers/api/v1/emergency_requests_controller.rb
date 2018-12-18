class Api::V1::EmergencyRequestsController < ApplicationController

  def create
    emergency_requester_id = Shift.find(params[:emergency_shift_id]).user_id
    @emergency_request = EmergencyRequest.new(request_params.merge(emergency_requester_id: emergency_requester_id))
    if @emergency_request.save!
      render json: format_json(@emergency_request), status: :created
    else
      head(:unprocessable_entity)
    end
  end

  def index
    organisation = User.find(params[:user_id]).organisation
    job_title = User.find(params[:user_id]).job_title

    @emergency_requests = EmergencyRequest.all

    relevant_requests = []

    @emergency_requests.each do |request|
      requester = User.find(request.emergency_requester_id)
      requester_organisation = requester.organisation
      requester_job_title = requester.job_title
      relevant_requests << request if (requester_organisation == organisation && requester_job_title == job_title)
    end

    render json: relevant_requests.map { |request| format_json(request) }
  end

  private

  def request_params
      params.permit(:comment, :emergency_shift_id)
  end

  def format_json(emergency_request)
    requested_emergency_shift = Shift.find(emergency_request.emergency_shift_id)
    emergency_requester_id = User.find(emergency_request.emergency_requester_id)

    {id: emergency_request.id, comment: emergency_request.comment,
        shiftId: emergency_request.emergency_shift_id,
        userId: emergency_request.emergency_requester_id,
        name: emergency_requester_id.name,
        start: requested_emergency_shift.start_time,
      end: requested_emergency_shift.end_time
    }
    end

end
