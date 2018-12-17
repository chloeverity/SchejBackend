class Api::V1::EmergencyRequestsController < ApplicationController

  def create
    emergency_requester_id = Shift.find(params[:emergency_shift_id]).user_id
    @emergency_request = EmergencyRequest.new(request_params.merge(emergency_requester_id: emergency_requester_id))
    if @emergency_request.save!
      render json: format_json_for_request(@emergency_request), status: :created
    else
      head(:unprocessable_entity)
    end
  end

  private

  def request_params
      params.permit(:comment, :emergency_shift_id)
  end

  def format_json_for_request(emergency_request)
    requested_emergency_shift = Shift.find(emergency_request.emergency_shift_id)
    emergency_requester_id = User.find(emergency_request.emergency_requester_id)

    {id: emergency_request.id, comment: emergency_request.comment,
        id: emergency_request.emergency_shift_id,
        userId: emergency_request.emergency_requester_id,
        name: emergency_requester_id.name,
        start: requested_emergency_shift.start_time,
      end: requested_emergency_shift.end_time
    }
    end

end
