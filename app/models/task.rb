class Task < ApplicationRecord
  validates :title, presence: true

  scope :incomplete, -> { where(completed_at: nil) }
end