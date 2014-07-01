desc "This task is called by the Heroku scheduler add-on"
task update_truck_schedule: :environment do
  require 'open-uri'

  page = Nokogiri::HTML(open("http://www.cityofboston.gov/foodtrucks/schedule-app-min.asp"))

  results = {}
  locations = []

  coordinates = {
                  "(20) Cleveland Circle, Cassidy Park at Beacon St" => "42.335071,-71.152305",
                  "(22) Financial District, Milk and Kilby Streets" => "42.357160,-71.055122",
                  "(8) Boston University West, on Commonwealth Ave" => "42.350137,-71.107375",
                  "City Hall Plaza, Fisher Park" => "42.359891,-71.058274",
                  "(4) Prudential, on Belvidere Street " => "42.346518,-71.082206",
                  "Greenway (at High St #1)" => "42.356771, -71.051249",
                  "(2) Back Bay, Copley Square North at Clarendon St" => "42.347414,-71.078689",
                  "(24) Financial District, Pearl Street at Franklin" => "42.35581796,-71.05475365",
                  "(29) Fenway - Northeastern University on Opera Place at Huntington" => "42.340410,-71.088976",
                  "(23) Chinatown/Park Street, Boylston St near Washington St" => "42.357636,-71.062965",
                  "(1) Back Bay, Copley Square West at Boylston St" => "42.350165,-71.076312",
                  "(7) Boston University East, on Commonwealth Ave" => "42.351075,-71.107211",
                  "(11) South End, Harrison Ave and East Concord St " => "42.336653,-71.073229",
                  "Rose Kennedy Greenway, Dewey Square, South Station" => "42.35276805,-71.05541643",
                  "Rose Kennedy Greenway, Milk Street by Aquarium" => "42.358729,-71.051842",
                  "(3) Back Bay, Copley Square South at Trinity Place" => "42.349913,-71.076289",
                  "(12) South End, Peter's Park on Washington St " => "42.343460,-71.067245",
                  "SoWa Open Market, 500 Harrison Avenue" => "42.342741,-71.065342",
                  "(25) Innovation District, Seaport Blvd at Thomson" => "42.352375,-71.046094",
                  "(18) West End, Blossom St at Emerson Place" => "42.364420,-71.069101",
                  "(32) Design Ctr (Innovation and Design Building)" => "42.344443,-71.033962",
                  "Rose Kennedy Greenway,Congress Street near Wharf" => "42.35369137,-71.05360458",
                  "(27) Charlestown Navy Yard at Baxter Road" => "42.374406,-71.055107",
                  "(30) Maverick Square at Sumner Street" => "42.368927,-71.039831",
                  "(31) Dudley Square at Dudley street" => "42.328952,-71.085761"
                }

  entries = page.css('tr.trFoodTrucks')

  entries.each do |entry|
    results[entry.css('td.com').text] ||= {
                                            "Sunday" => { "Breakfast" => nil, "Lunch" => nil,
                                                          "Dinner" => nil, "Late Night" => nil },
                                            "Monday" => { "Breakfast" => nil, "Lunch" => nil,
                                                          "Dinner" => nil, "Late Night" => nil },
                                            "Tuesday" => { "Breakfast" => nil, "Lunch" => nil,
                                                           "Dinner" => nil, "Late Night" => nil },
                                            "Wednesday" => { "Breakfast" => nil, "Lunch" => nil,
                                                             "Dinner" => nil, "Late Night" => nil },
                                            "Thursday" => { "Breakfast" => nil, "Lunch" => nil,
                                                            "Dinner" => nil, "Late Night" => nil },
                                            "Friday" => { "Breakfast" => nil, "Lunch" => nil,
                                                          "Dinner" => nil, "Late Night" => nil },
                                            "Saturday" => { "Breakfast" => nil, "Lunch" => nil,
                                                            "Dinner" => nil, "Late Night" => nil }
                                          }
    location = entry.css('td.loc').text.split(';')[-1]

    if !locations.include?(location)
      locations << location
    end

    results[entry.css('td.com').text][entry.css('td.dow').text][entry.css('td.tod').text] = [location, coordinates[location]]
  end

  if results.size > 0
    Location.delete_all

    results.each do |truck, days|
      days.each do |dow, meals|
        meals.each do |tod, loc|
          if !loc.nil?
            if truck[-1].to_i != 0
              truck = truck.chop.strip
            end
            food_truck = FoodTruck.where(name: truck)
            food_truck.each do |cart|
              Location.create!(day_of_week: dow, time_of_day: tod,
                               address: loc[0], coordinates: loc[1],
                               food_truck_id: cart.id)
            end
          end
        end
      end
    end
  end
end
