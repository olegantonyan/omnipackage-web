# frozen_string_literal: true

class PasswordResetToken < ::ApplicationRecord
  belongs_to :user, class_name: '::User'
end
