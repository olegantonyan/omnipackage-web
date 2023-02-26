# frozen_string_literal: true

class Agent < ::ApplicationRecord
  encrypts :apikey, deterministic: true

  has_many :agent_tasks, class_name: '::Agent::Task', dependent: :destroy

  validates :apikey, presence: true, uniqueness: true
end
