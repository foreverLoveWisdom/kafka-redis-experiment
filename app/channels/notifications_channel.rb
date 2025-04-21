# frozen_string_literal: true

class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "\n\n\n[WebSocket] ✅ Subscribed to notifications_#{params[:user_id]}"
    stream_from "notifications_#{params[:user_id]}"
    Rails.logger.info "\n\n\nAfter stream from....."
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
