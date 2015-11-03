module ToHistogram

  class StdoutPrint
    def initialize(histogram)
      @histogram = histogram
    end

    def invoke
      last_value = nil
      total_data_value_length = (@histogram.map { |b| b.length }).reduce(:+)
      printf("%-20s %-20s %-30s %-20s \n\n", "range", "frequency", "  percentage (out of #{total_data_value_length})", "histogram (percetage)")
      
      @histogram.each do |b|
        range       = last_value.nil? ? "#{b[0]} to #{b[-1]}" : "#{last_value + 1} to #{b[-1]}"
        frequency   = b.length
        percentage  = ((frequency.to_f / total_data_value_length) * 100)
        stars       = ''
        percentage.round.times { |x| stars << '*' }

        printf("%-20s | %-20s | %-30s | %-20s \n", range, frequency, ('%.4f' % percentage), stars)
        last_value = b[-1]
      end
    end

  end
end