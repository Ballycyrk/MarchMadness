# Users
User.create!(handle:  "Ballycyrk",
             first_name: "Colin",
             last_name: "McKenna",
             email: "colinjmckenna@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(handle:  "Slayer of Fun",
             first_name: "Jesica",
             last_name: "Avellone",
             email: "jesica.avellone@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following Relationships
users = User.all
users.each { |followed| user.follow(followed) }
users.each { |follower| follower.follow(user) }

# Conferences
Conference.create!(con_name: "America East Conference",
                   con_nickname: "America East",
                   founded: 1979,
                   members: 9,
                   headquarter: "Boston, Massachusetts")

Conference.create!(con_name: "American Athletic Conference",
                   con_nickname: "The American",
                   founded: 1979,
                   members: 11,
                   headquarter: "Providence, Rhode Island")

Conference.create!(con_name: "Atlantic 10 Conference",
                   con_nickname: "A-10",
                   founded: 1975,
                   members: 14,
                   headquarter: "Newport News, Virginia")

Conference.create!(con_name: "Atlantic Coast Conference",
                   con_nickname: "ACC",
                   founded: 1953,
                   members: 15,
                   headquarter: "Greensboro, North Caolina")

Conference.create!(con_name: "Atlantic Sun Conference",
                   con_nickname: "A-Sun",
                   founded: 1978,
                   members: 9,
                   headquarter: "Macon, Georgia")

Conference.create!(con_name: "Big 12 Conference",
                   con_nickname: "Big 12",
                   founded: 1996,
                   members: 10,
                   headquarter: "Irving, Texas")

Conference.create!(con_name: "Big East Conference",
                   con_nickname: "Big East",
                   founded: 2013,
                   members: 10,
                   headquarter: "New York, New York")

Conference.create!(con_name: "Big Sky Conference",
                   con_nickname: "Big Sky",
                   founded: 1963,
                   members: 12,
                   headquarter: "Ogden, Utah")

Conference.create!(con_name: "Big South Conference",
                   con_nickname: "Big South",
                   founded: 1983,
                   members: 11,
                   headquarter: "Charlotte, North Carolina")

Conference.create!(con_name: "Big 10 Conference",
                   con_nickname: "Big Ten",
                   founded: 1896,
                   members: 14,
                   headquarter: "Rosemont, Illinois")

Conference.create!(con_name: "Big West Conference",
                   con_nickname: "Big West",
                   founded: 1969,
                   members: 9,
                   headquarter: "Irvine, California")

Conference.create!(con_name: "Colonial Athletic Association",
                   con_nickname: "CAA",
                   founded: 1983,
                   members: 10,
                   headquarter: "Richmond, Virginia")

Conference.create!(con_name: "Conference USA",
                   con_nickname: "C-USA",
                   founded: 1995,
                   members: 14,
                   headquarter: "Irving, Texas")

Conference.create!(con_name: "Horizon League",
                   con_nickname: "Horizon",
                   founded: 1979,
                   members: 9,
                   headquarter: "Indianapolis, Indiana")

Conference.create!(con_name: "Ivy League",
                   con_nickname: "Ivy League",
                   founded: 1954,
                   members: 8,
                   headquarter: "Princeton, New Jersey")

Conference.create!(con_name: "Metro Atlantic Athletic Conference",
                   con_nickname: "MAAC",
                   founded: 1980,
                   members: 11,
                   headquarter: "Edison, New Jersey")

Conference.create!(con_name: "Mid-American",
                   con_nickname: "MAC",
                   founded: 1946,
                   members: 12,
                   headquarter: "Cleveland, Ohio")

Conference.create!(con_name: "Mid-Eastern Athletic Conference",
                   con_nickname: "MEAC",
                   founded: 1970,
                   members: 13,
                   headquarter: "Norfolk, Virginia")

Conference.create!(con_name: "Missouri Valley Conference",
                   con_nickname: "MVC",
                   founded: 1907,
                   members: 10,
                   headquarter: "St. Louis, Missouri")

Conference.create!(con_name: "Mountain West Conference",
                   con_nickname: "MW",
                   founded: 1999,
                   members: 11,
                   headquarter: "Colorado Springs, Colorado")

Conference.create!(con_name: "Northeast Conference",
                   con_nickname: "NEC",
                   founded: 1981,
                   members: 10,
                   headquarter: "Somerset, New Jersey")

Conference.create!(con_name: "Ohio Valley Conference",
                   con_nickname: "OVC",
                   founded: 1948,
                   members: 12,
                   headquarter: "Brentwood, Tennessee")

Conference.create!(con_name: "Pacific-12 Conference",
                   con_nickname: "Pac-12",
                   founded: 1959,
                   members: 12,
                   headquarter: "Walnut Creek, California")

Conference.create!(con_name: "Patriot League",
                   con_nickname: "Patriot",
                   founded: 1986,
                   members: 10,
                   headquarter: "Center Valley, Pennsylvania")

Conference.create!(con_name: "Southeastern Conference",
                   con_nickname: "SEC",
                   founded: 1932,
                   members: 14,
                   headquarter: "Birmingham, Alabama")

Conference.create!(con_name: "Southern Conference",
                   con_nickname: "SoCon",
                   founded: 1921,
                   members: 10,
                   headquarter: "Spartanburg, Carolina")

Conference.create!(con_name: "Southland Conference",
                   con_nickname: "Southland",
                   founded: 1963,
                   members: 13,
                   headquarter: "Frisco, Texas")

Conference.create!(con_name: "Southwestern Athletic Conference",
                   con_nickname: "SWAC",
                   founded: 1920,
                   members: 10,
                   headquarter: "Birmingham, Alabama")

Conference.create!(con_name: "The Summit League",
                   con_nickname: "The Summit",
                   founded: 1982,
                   members: 9,
                   headquarter: "Elmhurst, Illinois")

Conference.create!(con_name: "Sun Belt Conference",
                   con_nickname: "Sun Belt",
                   founded: 1976,
                   members: 10,
                   headquarter: "New Orleans, Louisiana")

Conference.create!(con_name: "West Coast Conference",
                   con_nickname: "WCC",
                   founded: 1952,
                   members: 10,
                   headquarter: "San Bruno, California")

Conference.create!(con_name: "Western Athletic Conference",
                   con_nickname: "WAC",
                   founded: 1962,
                   members: 8,
                   headquarter: "Englewood, Colorado")
