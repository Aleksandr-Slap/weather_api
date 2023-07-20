class Forecast < ApplicationRecord
  validates :max, presence: true
  validates :min, presence: true
  validates :avg, presence: true
  validates :history, presence: true
end
