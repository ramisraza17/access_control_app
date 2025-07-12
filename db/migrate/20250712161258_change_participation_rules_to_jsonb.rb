class ChangeParticipationRulesToJsonb < ActiveRecord::Migration[7.0]
  def change
    change_column :organizations, :participation_rules, :jsonb, using: 'participation_rules::jsonb', default: {}
  end
end