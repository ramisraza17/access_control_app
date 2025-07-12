class ReportsController < ApplicationController
  include OrganizationAccess

  def index
    @reports = current_organization.reports
  end

  def generate
    report_type = params[:report_type]
    data = generate_report_data(report_type)
    
    report = current_organization.reports.create!(
      title: "#{report_type.capitalize} Report - #{Date.today}",
      content: data.to_json,
      report_type: report_type
    )
    
    redirect_to organization_report_path(current_organization, report),
                notice: 'Report generated successfully'
  end

  private

  def generate_report_data(type)
    case type
    when 'membership'
      {
        total_members: current_organization.users.count,
        roles_distribution: Membership.group(:role).count,
        new_members: current_organization.users.where('created_at > ?', 30.days.ago).count
      }
    when 'engagement'
      {
        active_users: rand(50..200),
        avg_session_time: "#{rand(5..45)} minutes",
        spaces_usage: Space.pluck(:name, :id).to_h { |n, id| [n, rand(10..100)] }
      }
    else
      { activity: 'Sample activity data' }
    end
  end
end
