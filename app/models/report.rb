class Report < ApplicationRecord
  belongs_to :organization
  REPORT_TYPES = %w[membership engagement activity].freeze
  validates :report_type, inclusion: { in: REPORT_TYPES }
end
