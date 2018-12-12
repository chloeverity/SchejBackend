class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.all

    render json: @shifts, status: :ok
  end

  def create
    p current_user
    @shift = Shift.new(shift_params)
    p @shift.save!

    render json: @shift.as_json(title: @shift.title, start_time: @shift.start_time, end_time: @shift.end_time), status: :created
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
    params.permit(:title, :start_time, :end_time).merge(user_id: 1)
  end
end
