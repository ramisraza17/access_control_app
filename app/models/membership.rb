class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  ROLES = %w[member moderator admin owner].freeze
  validates :role, inclusion: { in: ROLES }

  def has_permission?(action)
    case action
    when :view_analytics then %w[admin owner].include?(role)
    when :manage_content then %w[moderator admin owner].include?(role)
    when :manage_users then %w[admin owner].include?(role)
    else false
    end
  end
end
