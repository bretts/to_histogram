require_relative './histogram'
require_relative './stdout_print'

class Array
  def to_histogram(num_buckets: 10, percentile: 100)
    histogram       = ToHistogram::Histogram.new(self, num_buckets, percentile)    
    stdout_print    = ToHistogram::StdoutPrint.new(histogram, self)

    stdout_print.invoke

    puts "\n\n"
    return nil
  end
end