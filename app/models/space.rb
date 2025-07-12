class Space < ApplicationRecord
  belongs_to :organization
  validates :min_age, :max_age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :name, presence: true
  validates :description, presence: true

  def age_appropriate?(user)
    user.age >= min_age && user.age <= max_age
  end
end
