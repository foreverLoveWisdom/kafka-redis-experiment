# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  attribute :status, :string
  enum :status, { unread: 'unread', read: 'read', failed: 'failed' }, validate: true

  validates :channel, :template_key, presence: true
end
