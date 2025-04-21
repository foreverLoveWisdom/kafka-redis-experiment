# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  enum status: { unread: 'unread', read: 'read', failed: 'failed' }

  validates :channel, :template_key, presence: true
end
