class Api::V1::RequestsController < ApplicationController

  def create
    requested_shift_holder_id = Shift.where(id: params[:requested_shift_id]).pluck(:user_id).first
    current_shift_holder_id = Shift.where(id: params[:current_shift_id]).pluck(:user_id).first
    @request = Request.new(request_params.merge(shift_holder_id: requested_shift_holder_id, shift_requester_id: current_shift_holder_id))
    @request.save!

    render json: @request.as_json( ), status: :created
  end

  def show_by_id
    @requests = Request.where(shift_holder_id: params[:user_id])

    render json: @requests, status: :ok
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
end
