# frozen_string_literal: true

class NotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id:, template_key:, payload:, channel: 'email')
    user = User.find(user_id)
    message = render_template(template_key, payload)

    case channel
    when 'email'
      EmailSender.send(user.email, message)

    when 'push'
      PushSender.send(user.device_token, message)

    when 'in_app'
      Rails.logger.info "\n\n\n📣 [Broadcast] Starting to broadcast to notifications_#{user.id}"
      Notification.create!(
        user: user,
        channel: channel,
        payload: payload,
        template_key: template_key,
        delivered_at: Time.current
      )

      ActionCable.server.broadcast(
        "notifications_#{user.id}",
        {
          identifier: { channel: 'NotificationsChannel', user_id: user.id }.to_json,
          message: {
            template_key: template_key,
            payload: payload,
            content: message
          }
        }
      )
      Rails.logger.info "\n\n\n✅ [Broadcast] Done broadcasting to notifications_#{user.id}"
    else
      raise 'Unknown channel'
    end
  end

  private

  def render_template(key, data)
    case key
    when 'transfer_success'
      "You received $#{data[:amount]} from #{data[:from_name]}"
    else
      'Unknown event'
    end
  end
end
