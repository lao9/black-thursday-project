module StatsCalculator

  def standard_deviation(set, average)

    std_sum = set.reduce(0) do |sum, num|
        sum + ((num - average) ** 2)
    end

    final_total = (Math.sqrt(std_sum / (set.count - 1))).round(2)
  end

  def day_of_the_week
    {0 => "Sunday",
    1 => "Monday",
    2 => "Tuesday",
    3 => "Wednesday",
    4 => "Thursday",
    5 => "Friday",
    6 => "Saturday"}
  end

end
