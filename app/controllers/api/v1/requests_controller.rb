class Api::V1::RequestsController < ApplicationController

  def create
    shift_holder_id = Shift.where(id: params[:shift_id]).pluck(:user_id).first
    @request = Request.new(request_params.merge(shift_holder_id: shift_holder_id))
    @request.save!

    render json: @request.as_json( ), status: :created
  end

  def show_by_id
    @requests = Request.where(shift_holder_id: params[:user_id])

    render json: @requests, status: :ok
  end

  private
  def request_params
      params.permit(:shift_id, :shift_requester_id)
  end
end
