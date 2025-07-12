class User < ApplicationRecord
  has_secure_password
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  validates :email, presence: true, uniqueness: true
  validates :date_of_birth, presence: true

  AGE_GROUPS = {
    child: 0..12,
    teen: 13..17,
    adult: 18..Float::INFINITY
  }.freeze

  def age
    return 0 unless date_of_birth
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def age_group
    group = AGE_GROUPS.find { |_, range| range.include?(age) }&.first
    group || :adult
  end

  def minor?
    age < 18
  end
end
