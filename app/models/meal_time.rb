module MealTime
  def self.get_meal_time
    # Breakfast: 6-10AM; Lunch 10AM-3PM; Dinner: 3-11PM; Late Night: 11PM-12AM
    hour = Time.now.getlocal.hour
    meal = "None"
    if hour >= 6 && hour < 10
      meal = "Breakfast"
    elsif hour >= 10 && hour < 15
      meal = "Lunch"
    elsif hour >= 15 && hour < 23
      meal = "Dinner"
    elsif hour >= 23
      meal = "Late Night"
    end
    meal
  end
end
