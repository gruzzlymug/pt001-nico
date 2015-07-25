# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

titles = %w(Dr. Mr. Mrs. Ms. Miss)
suffixes = %w(I II III IV V DDS DVM Jr. MD PhD Sr.)

state_abbreviations = {
  'AL'=>'ALABAMA',
  'AK'=>'ALASKA',
  'AZ'=>'ARIZONA',
  'AR'=>'ARKANSAS',
  'CA'=>'CALIFORNIA',
  'CO'=>'COLORADO',
  'CT'=>'CONNECTICUT',
  'DE'=>'DELAWARE',
  'DC'=>'DISTRICT OF COLUMBIA',
  'FL'=>'FLORIDA',
  'GA'=>'GEORGIA',
  'HI'=>'HAWAII',
  'ID'=>'IDAHO',
  'IL'=>'ILLINOIS',
  'IN'=>'INDIANA',
  'IA'=>'IOWA',
  'KS'=>'KANSAS',
  'KY'=>'KENTUCKY',
  'LA'=>'LOUISIANA',
  'ME'=>'MAINE',
  'MD'=>'MARYLAND',
  'MA'=>'MASSACHUSETTS',
  'MI'=>'MICHIGAN',
  'MN'=>'MINNESOTA',
  'MS'=>'MISSISSIPPI',
  'MO'=>'MISSOURI',
  'MT'=>'MONTANA',
  'NE'=>'NEBRASKA',
  'NV'=>'NEVADA',
  'NH'=>'NEW HAMPSHIRE',
  'NJ'=>'NEW JERSEY',
  'NM'=>'NEW MEXICO',
  'NY'=>'NEW YORK',
  'NC'=>'NORTH CAROLINA',
  'ND'=>'NORTH DAKOTA',
  'OH'=>'OHIO',
  'OK'=>'OKLAHOMA',
  'OR'=>'OREGON',
  'PA'=>'PENNSYLVANIA',
  'RI'=>'RHODE ISLAND',
  'SC'=>'SOUTH CAROLINA',
  'SD'=>'SOUTH DAKOTA',
  'TN'=>'TENNESSEE',
  'TX'=>'TEXAS',
  'UT'=>'UTAH',
  'VT'=>'VERMONT',
  'VA'=>'VIRGINIA',
  'WA'=>'WASHINGTON',
  'WV'=>'WEST VIRGINIA',
  'WI'=>'WISCONSIN',
  'WY'=>'WYOMING'
}
state_abbreviations = state_abbreviations.invert

# remove anything in the users table
User.delete_all

users = ActiveSupport::JSON.decode(File.read('db/seeds/user_data.json'))

users.each do |user|
  # remove titles and suffixes from the names
  # titles and suffixes could easily be saved to the DB if desired
  name_parts = user['name'].split(' ')
  name_parts.shift if titles.include? name_parts.first
  name_parts.pop if suffixes.include? name_parts.last
  name = name_parts.join(' ')

  # make phone format consistent
  phone = user['phone']
  m = /[1.]?([\d]{3}).([\d]{3}).([\d]{4})/.match(phone)
  phone = "(#{m[1]}) #{m[2]}-#{m[3]}" if m
  # puts "#{name} #{phone} #{user['phone']}"

  # abbreviate states
  state = state_abbreviations[user['state'].upcase]

  User.create!(
    name: name,
    line1: user['line1'],
    line2: user['line2'],
    city: user['city'],
    state: state,
    zip: user['zip'],
    phone: phone
  )
end
