class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.all
    render json: @shifts, status: :ok
  end

  def create
    @shift = Shift.new(shift_params)
    @shift.save!

    render json: @shift.as_json(title: @shift.title, start_time: @shift.start_time, end_time: @shift.end_time, user_id: @shift.user_id), status: :created
  end

  def destroy
    @shift = Shift.find(params[:id])

    if @shift.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def shift_params
    p 'params are'
    p params
    params.permit(:title, :start_time, :end_time, :user_id)
  end
end
