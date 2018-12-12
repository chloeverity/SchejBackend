class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.all

    render json: @shifts, status: :ok
  end

  def create
    @shift = Shift.new(shift_params)
    @shift.save
    render json: @shift, status: :created
  end

  def destroy
    @shift = Shift.where(id: params[:id]).first
    if @shift.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def shift_params
    params.permit(:title, :start_time, :end_time)
  end
end
