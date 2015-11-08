module Averages
    def mean(array)
      array.reduce(:+) / array.length
    end

    def median(array)
      array[array.length / 2]
    end

    def mode(array)
      frequency = array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      
      array.max_by { |v| frequency[v] }
    end
end