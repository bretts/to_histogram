require_relative './averages'

module ToHistogram

  class StdoutPrint
    include Averages

    def initialize(histogram, stdout=$stdout)
      @histogram      = histogram
      @stdout         = stdout
    end

    def invoke      
      if @histogram.length == 0
        @stdout.puts "You have no histogram data"
      elsif (@histogram.length == 1 && (@histogram[0].from == 0 && @histogram[0].to == -1))
        @stdout.puts "The data you have provided is not histogram-able" 
      else
        print_header
        print_body
      end
    end

    private
    def print_header
      @stdout.print "\r**************************************************************\n"
      @stdout.puts "Results for #to_histogram(num_buckets: #{@histogram.num_buckets}, bucket_width: #{@histogram.bucket_width}, percentile: #{@histogram.percentile}, print_info: true)"
      
      @stdout.puts "\n"
  
      percentile_info = (@histogram.percentile == 100) ? '' : "(Numbers limited to the #{@histogram.percentile}th percentile)"
      @stdout.puts "Data set used in this calculation #{percentile_info}"
      @stdout.puts "Data set Size: #{@histogram.bucket_contents_length} items"

      @stdout.puts "Min Value: #{@histogram[0].contents[0]}, Max Value: #{@histogram[-1].contents[-1]}"
      @stdout.puts "Mean: #{mean(@histogram.bucket_contents_values)}, Median: #{median(@histogram.bucket_contents_values)}, Mode: #{mode(@histogram.bucket_contents_values)}"
      @stdout.puts "\n"
            
      @stdout.puts "Histogram bucket width: #{@histogram.bucket_width}"
      @stdout.puts "**************************************************************\n\n"
    end

    def print_body
      @stdout.printf("%-20s %-20s %-30s %-20s \n\n", "Range", "Frequency", "  Percentage", "Histogram (each * =~ 1%)")
    
      @histogram.each_with_index do |b, i|
        range       = "#{@histogram[i].from} to #{@histogram[i].to}"
        frequency   = b.contents.length
        percentage  = ((frequency.to_f / @histogram.bucket_contents_length) * 100)
        stars       = ''

        percentage.ceil.times { |x| stars << '*' }
        stars.length.upto(100) { |x| stars << ' ' }

        if(i == (@histogram.length - 1))
          if(b.contents[-1] - b.contents[0] != 0 && (b.contents[-1] - b.contents[0] > @histogram.bucket_width))
            range = "> than #{b.contents[0]}"
          end
        end

        @stdout.printf("%-20s | %-20s | %-30s | %-20s \n", range, frequency, ('%.4f' % percentage), stars)
      end
    end

  end
end