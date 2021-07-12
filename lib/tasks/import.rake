namespace :import do
  desc "Importing data from json file"

  task restaurants: :environment do
    puts "importing restaurants"
    filename = File.open(Rails.root.join('lib', 'restaurants.json'))
    file = File.read(filename)
    data = JSON.parse(file)
    restos = []
    data.each do |row|
      resto = Restaurant.new(
        name: row["name"],
        latitude: row["location"].split(",").first.to_f,
        longitude: row["location"].split(",").second.to_f,
        balance: row["balance"]
      )

      if row["business_hours"]
        ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].each_with_index do |day, idx|
          p day = row["business_hours"].match(/#{day}.*?:\s\K(\d\d?:?\d?\d? [A|P]M) - (\d\d?:?\d?\d? [A|P]M)/i)
          if day
            resto.business_hours.build(
              day: idx + 1,
              open_at: day[1],
              close_at: day[2]
            )
          end
        end
      end

      row["menu"].each do |m|
        resto.menus.build(
          name: m["name"],
          price: m['price'])
      end
      restos << resto
    end
    Restaurant.import restos, recursive: true
  end

  task users: :environment do
    puts "importing users"
    filename = File.open(Rails.root.join('lib', 'users.json'))
    file = File.read(filename)
    data = JSON.parse(file)
    users = []
    data.each do |row|
      user = User.new(
        name: row["name"],
        balance: row["balance"],
        latitude: row["location"].split(",").first.to_f,
        longitude: row["location"].split(",").second.to_f)
      row["purchases"].each do |purchase|
        resto = Restaurant.where(name: purchase['restaurant_name']).joins(:menus).where(menus: { name: purchase['dish'] }).first
        dish = resto.menus.where(name: purchase['dish']).first
        user.purchases.build(
          amount: purchase["amount"],
          date: purchase["date"],
          restaurant: resto,
          menu: dish
        )
      end
      users << user
    end

    User.import users, recursive: true

  end

end

