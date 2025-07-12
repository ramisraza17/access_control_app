class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :spaces, dependent: :destroy
  has_many :reports, dependent: :destroy

  DEFAULT_RULES = {
    child: { content_filter: 'G', requires_consent: true },
    teen: { content_filter: 'PG-13', requires_consent: true },
    adult: { content_filter: 'R', requires_consent: false }
  }.freeze

  def participation_rules
    rules = if self[:participation_rules].is_a?(String)
              JSON.parse(self[:participation_rules]).deep_symbolize_keys
            else
              self[:participation_rules] || DEFAULT_RULES
            end
    
    User::AGE_GROUPS.keys.each do |age_group|
      rules[age_group] ||= DEFAULT_RULES[age_group] || {}
    end
    
    rules
  end

  def participation_rules=(value)
    self[:participation_rules] = value.is_a?(String) ? value : value.to_json
  end

  validate :complete_participation_rules

  private

  def complete_participation_rules
    return unless participation_rules_changed?
    
    rules = participation_rules
    
    missing_groups = User::AGE_GROUPS.keys - rules.keys
    if missing_groups.any?
      errors.add(:participation_rules, "missing rules for age groups: #{missing_groups.join(', ')}")
    end
  end
end
