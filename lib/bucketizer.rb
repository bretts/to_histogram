module ToHistogram

  class Bucketizer

    def initialize(array, num_buckets)
      @arr                = array.sort
      @num_buckets        = num_buckets
      @bucket_increments  = get_bucket_increment
    end
    attr_reader :bucket_increments

    def create_buckets
      l_index               = 0
      next_bucket           = (@bucket_increments == 1 && @arr[0] == 0) ? 0 : @bucket_increments
      buckets               = []

      @arr.each_with_index do |e, i|
        break if buckets.length == (@num_buckets - 1)

        if !(e <= next_bucket)
          buckets << @arr[l_index..(i - 1)]

          # Special case where all of the results fit into the first bucket
          if buckets[0].length == @arr.length
            l_index = (@arr.length)
            break
          end

          l_index = i
          next_bucket += @bucket_increments
        end
      end

      # Stuff the remainder into the last bucket
      if(l_index <= (@arr.length - 1))
        buckets << @arr[l_index..(@arr.length - 1)]
      end

      return buckets
    end

    private
    def get_bucket_increment
      if(@arr.length == 0)
        return 0
      elsif(@arr.length <= @num_buckets)
        increment = ((@arr[-1] - @arr[0]) / @num_buckets)
      else
        increment = ((@arr[(@arr.length * 0.9).to_i - 1] - @arr[(@arr.length * 0.1).to_i - 1]) / @num_buckets.to_f).ceil
      end

      return increment
    end

  end
end