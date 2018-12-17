class Api::V1::RequestsController < ApplicationController

  def create
    requested_shift = Shift.find(params[:requested_shift_id])
    requested_shift_holder = User.find(requested_shift.user_id)
    current_shift = Shift.find(params[:current_shift_id])
    current_shift_holder = User.find(current_shift.user_id)
    @request = Request.new(request_params.merge(shift_holder_id: requested_shift_holder.id, shift_requester_id: current_shift_holder.id))
    @request.save!

    render json: format_json_for_request(@request), status: :created
  end

  def show_by_id
    @requests = Request.where(shift_holder_id: params[:user_id])

    render json: (@requests.map do |request|
      format_json_for_request(request)
        end), status: :ok
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

    {id: request.id, comment: request.comment, 'requested_shift':
      {id: request.requested_shift_id,
        requested_shift_user_id: request.shift_holder_id,
        requested_shift_holder_name: requested_shift_holder.name,
        requested_shift_start: requested_shift.start_time,
        requested_shift_end: requested_shift.end_time},
      'current_shift':
        { id: request.current_shift_id,
          current_shift_user_id: request.shift_requester_id,
          current_shift_holder_name: current_shift_holder.name,
          current_shift_start: current_shift.start_time,
          current_shift_end: current_shift.end_time}
      }
    end
end
