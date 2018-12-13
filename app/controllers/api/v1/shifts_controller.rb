class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.where(organisation: params[:organisation])
    render json: @shifts, status: :ok
  end

  def create
    organisation = User.where(id: params[:user_id]).pluck(:organisation).first
    @shift = Shift.new(shift_params.merge({:organisation => organisation}))
    @shift.save!

    render json: @shift.as_json(title: @shift.title, start_time: @shift.start_time, end_time: @shift.end_time, user_id: @shift.user_id, organisation: @shift.organisation), status: :created
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

  def shift_params()
    params.permit(:title, :start_time, :end_time, :user_id)
  end
end
