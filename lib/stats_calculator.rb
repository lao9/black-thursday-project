module StatsCalculator

  def calculate_average(item_list, divisor=item_list.count)
    list_sum = item_list.reduce(:+)
    (list_sum.to_f / divisor).round(2)
  end

  def standard_deviation(set, average=calculate_average(set))
    std_sum = set.reduce(0) do |sum, num|
        sum + ((num - average) ** 2)
    end
    final_total = (Math.sqrt(std_sum / (set.count - 1))).round(2)
  end

  def unique_element_counter(input_arr, symbols=false)
    input_arr.reduce(Hash.new(0)) do |output, key|
      key = key.to_sym if symbols
      output[key] += 1
      output
    end
  end

  def map_by_quantity(grouped_list)
    output = grouped_list.map do |key, value|
      Array.new(value.count, key)
    end
    output.flatten
  end

  def compare_list_to_stdev_threshold(set, threshold)
    output = set.map do |key, value|
      key if value >= threshold
    end
    output.compact
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
