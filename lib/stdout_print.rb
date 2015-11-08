require_relative './averages'

module ToHistogram

  class StdoutPrint
    include Averages

    def initialize(histogram, original_array)
      @histogram      = histogram
      @original_array = original_array.sort
    end

    def invoke
      print_header
      
      print_body
    end

    private
    def print_header
      puts "\n**************************************************************"
      puts "Results for #to_histogram(num_buckets: #{@histogram.num_buckets}, percentile: #{@histogram.percentile}, print_info: true)"
      
      puts "\n"
  
      percentile_info = (@histogram.percentile == 100) ? '' : "(Numbers limited to the #{@histogram.percentile}th percentile)"
      puts "Data set used in this calculation #{percentile_info}"
      puts "Data set Size: #{@histogram.arr.length} items"
      puts "Min Value: #{@histogram.arr[0]}, Max Value: #{@histogram.arr[-1]}"
      puts "Mean: #{mean(@histogram.arr)}, Median: #{median(@histogram.arr)}, Mode: #{mode(@histogram.arr)}"
      puts "\n"
            
      puts "Histogram bucket sizes: #{@histogram.increments}"
      puts "**************************************************************\n\n"
    end

    def print_body
      total_data_value_length = (@histogram.map { |b| b.length }).reduce(:+)
      printf("%-20s %-20s %-30s %-20s \n\n", "Range", "Frequency", "  Percentage", "Histogram (each * =~ 1%)")
      
      @histogram.each_with_index do |b, i|
        next_bucket = (@histogram[i + 1]) ? @histogram[i + 1][0] : b[-1]
        range       = "#{b[0]} to #{next_bucket}"
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
      end
    end

  end
end