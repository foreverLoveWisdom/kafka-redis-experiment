# frozen_string_literal: true

class NotificationsController < ApplicationController
  def create
    NotificationJob.perform_later(
      user_id: params[:user_id],
      template_key: params[:template_key],
      payload: params[:payload].to_unsafe_h,
      channel: params[:channel] || 'in_app'
    )

    render json: { status: 'queued' }, status: :ok
  end
end
