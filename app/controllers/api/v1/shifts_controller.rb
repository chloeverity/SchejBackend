class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.all

    render json: @shifts, status: :ok
  end

  def create
    @shift = Shift.create(shift_params)
  end

  private

  def shift_params
    params.permit(:title, :start_time, :end_time)
  end
end
