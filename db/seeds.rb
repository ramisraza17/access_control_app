# Clear existing data
Membership.destroy_all
Space.destroy_all
Report.destroy_all
Organization.destroy_all
User.destroy_all

# Create users
user1 = User.create!(
  full_name: "John Doe",
  email: "john@example.com",
  password: "password",
  date_of_birth: 30.years.ago,
  parental_consent: true
)

user2 = User.create!(
  full_name: "Jane Smith",
  email: "jane@example.com",
  password: "password",
  date_of_birth: 25.years.ago,
  parental_consent: true
)

minor_user = User.create!(
  full_name: "Alex Johnson",
  email: "alex@example.com",
  password: "password",
  date_of_birth: 15.years.ago,
  parental_consent: false,
  consent_token: SecureRandom.hex(20)
)

# Create organizations
tech_org = Organization.create!(
  name: "Tech Innovators",
  description: "A community for technology enthusiasts and innovators.",
  participation_rules: {
    child: { content_filter: 'G', requires_consent: true },
    teen: { content_filter: 'PG-13', requires_consent: true },
    adult: { content_filter: 'R', requires_consent: false }
  }.to_json # Convert to JSON string
)

art_org = Organization.create!(
  name: "Art Lovers",
  description: "A space for artists and art lovers to connect.",
  participation_rules: {
    child: { content_filter: 'G', requires_consent: true },
    teen: { content_filter: 'PG', requires_consent: true },
    adult: { content_filter: 'PG-13', requires_consent: false }
  }.to_json # Convert to JSON string
)

# Create memberships
Membership.create!(
  user: user1,
  organization: tech_org,
  role: 'owner'
)

Membership.create!(
  user: user1,
  organization: art_org,
  role: 'admin'
)

Membership.create!(
  user: user2,
  organization: tech_org,
  role: 'member'
)

Membership.create!(
  user: minor_user,
  organization: tech_org,
  role: 'member'
)

# Create spaces
Space.create!(
  name: "Ruby Developers",
  description: "A space for Ruby and Rails developers.",
  organization: tech_org,
  min_age: 18,
  max_age: 100
)

Space.create!(
  name: "Young Coders",
  description: "A space for young programmers to learn and grow.",
  organization: tech_org,
  min_age: 10,
  max_age: 17
)

Space.create!(
  name: "Contemporary Art",
  description: "Discussion and sharing of contemporary art.",
  organization: art_org,
  min_age: 13,
  max_age: 100
)

# Create reports
Report.create!(
  title: "Monthly Membership Report - #{Date.today}",
  content: { 
    total_members: 50, 
    new_members: 5, 
    roles_distribution: { 'member' => 40, 'moderator' => 5, 'admin' => 3, 'owner' => 2 } 
  }.to_json,
  organization: tech_org,
  report_type: 'membership'
)

Report.create!(
  title: "Engagement Overview - #{Date.today}",
  content: { 
    active_users: 120, 
    avg_session_time: "22 minutes", 
    spaces_usage: { "Ruby Developers" => 45, "Young Coders" => 30 } 
  }.to_json,
  organization: tech_org,
  report_type: 'engagement'
)

puts "Seed data created successfully!"
puts "Test users:"
puts "  Admin/Owner: john@example.com / password"
puts "  Regular User: jane@example.com / password"
puts "  Minor User: alex@example.com / password"
