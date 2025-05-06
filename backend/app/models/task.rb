class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, length: { maximum: 1000 }, allow_blank: true
  validates :completed, inclusion: { in: [ true, false ] }
end
