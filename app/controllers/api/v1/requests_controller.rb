class Api::V1::RequestsController < ApplicationController

  def create
    requested_shift_holder_id = Shift.find(params[:requested_shift_id]).user_id
    current_shift_holder_id = Shift.find(params[:current_shift_id]).user_id
    @request = Request.new(request_params.merge(shift_holder_id: requested_shift_holder_id, shift_requester_id: current_shift_holder_id))

    if @request.save
      render json: format_json_for_request(@request), status: :created
    else
      head(:unprocessable_entity)
    end
  end

  def show_by_id
    @requests = Request.where(shift_holder_id: params[:user_id])

    render json: @requests.map { |request| format_json_for_request(request) },
      status: :ok
  end

  def destroy
    @request = Request.find(params[:id])

    if @request.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private
  def request_params
      params.permit(:current_shift_id, :requested_shift_id, :shift_requester_id , :comment)
  end

  def format_json_for_request(request)
    requested_shift = Shift.find(request.requested_shift_id)
    requested_shift_holder = User.find(request.shift_requester_id)
    current_shift = Shift.find(request.current_shift_id)
    current_shift_holder = User.find(request.shift_holder_id)

    {id: request.id, comment: request.comment, 'requestedShift':
      {id: request.requested_shift_id,
        userId: request.shift_holder_id,
        name: requested_shift_holder.name,
        start: requested_shift.start_time,
      end: requested_shift.end_time},
      'currentShift':
        { id: request.current_shift_id,
          userId: request.shift_requester_id,
          name: current_shift_holder.name,
          start: current_shift.start_time,
          end: current_shift.end_time}
      }
    end
end
