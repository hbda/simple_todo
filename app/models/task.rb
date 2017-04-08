class Task < ApplicationRecord
  enum status: {
    active: 0,
    completed: 1
  }

  validates :name, :priority, presence: true
end
