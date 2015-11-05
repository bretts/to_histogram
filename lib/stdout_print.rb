module ToHistogram

  class StdoutPrint
    def initialize(histogram)
      @histogram = histogram
    end

    def invoke
      total_data_value_length = (@histogram.map { |b| b.length }).reduce(:+)
      printf("%-20s %-20s %-30s %-20s \n\n", "range", "frequency", "  percentage (out of #{total_data_value_length})", "histogram (percetage)")
      
      @histogram.each_with_index do |b, i|
        range       = "#{b[0]} to #{b[-1]}"
        frequency   = b.length
        percentage  = ((frequency.to_f / total_data_value_length) * 100)
        stars       = ''
        percentage.round.times { |x| stars << '*' }

        if(i == (@histogram.length - 1))
          if(b[-1] - b[0] != 0 && (b[-1] - b[0] > @histogram.increments))
            range = "> than #{b[0]}"
          end
        end

        printf("%-20s | %-20s | %-30s | %-20s \n", range, frequency, ('%.4f' % percentage), stars)
        last_value = b[-1]
      end
    end

  end
end