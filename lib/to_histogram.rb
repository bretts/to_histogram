require_relative './histogram'
require_relative './stdout_print'

class Array
  def to_histogram(num_buckets: 10, percentile: 100, print_info: true)
    histogram       = ToHistogram::Histogram.new(self, num_buckets, percentile)    
    stdout_print    = ToHistogram::StdoutPrint.new(histogram, self)

    stdout_print.invoke if print_info

    return histogram
  end
end

data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462]

data.to_histogram(num_buckets: 10, percentile: 100)
data.to_histogram(num_buckets: 10, percentile: 90)