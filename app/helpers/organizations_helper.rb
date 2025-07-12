module OrganizationsHelper
  def display_rules(rules)
    return "No rules defined" unless rules
    
    rules.map do |key, value|
      "#{key.to_s.humanize}: #{value}"
    end.join(", ")
  end
end
