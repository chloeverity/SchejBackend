# frozen_string_literal: true

class Api::V1::ShiftsController < ApplicationController
  def index
    @shifts = Shift.where(organisation: params[:organisation])
                   .where(job_title: params[:job_title])

    render json: @shifts, status: :ok
  end

  def create
    organisation = User.where(id: params[:user_id]).pluck(:organisation).first
    job_title = User.where(id: params[:user_id]).pluck(:job_title).first
    @shift = Shift.new(
      shift_params.merge(organisation: organisation, job_title: job_title)
    )
    @shift.save!

    render json: @shift.as_json, status: :created
  end

  def update
    shift1 = Shift.find(params[:id])
    shift2 = Shift.find(params[:other_id])
    swapped_params = swap_params(shift1, shift2)
    shift1.update(swapped_params[:shift1_hash])
    shift2.update(swapped_params[:shift2_hash])
  end

  def destroy
    @shift = Shift.find(params[:id])

    if @shift.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  def show_by_id
    @user = User.find(params[:user_id])
    @shifts = @user.shifts

    render json: @shifts, status: :ok
  end

  private

  def shift_params
    params.permit(:title, :start_time, :end_time, :user_id, :email)
  end

  def swap_params(shift1, shift2)
    {
      shift1_hash: {
        title: shift2.title,
        start_time: shift1.start_time,
        end_time: shift1.end_time,
        user_id: shift2.user_id,
        email: shift2.email
      },
      shift2_hash: {
        title: shift1.title,
        start_time: shift2.start_time,
        end_time: shift2.end_time,
        user_id: shift1.user_id,
        email: shift1.email
      }
    }
  end
end
