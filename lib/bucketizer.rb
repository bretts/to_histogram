require_relative './bucket'

module ToHistogram

  class Bucketizer

    def initialize(array, num_buckets: 20, bucket_width: 'auto', percentile: 100)
      @arr                = array.sort
      @num_buckets        = num_buckets
      @percentile         = percentile

      remove_elements_outside_of_percentile
      @bucket_width  = (bucket_width == 'auto') ? get_bucket_increment : bucket_width
    end
    attr_reader :bucket_width

    def create_buckets
      l_index               = 0
      last_bucket           = @arr[0]
      next_bucket           = get_initial_next_bucket(@bucket_width)
      buckets               = []

      # Deal with the special case where we have elements that == 0 and an increment sizes of 1 (count 0 as a value and don't lump it in with 1)
      if(@arr.count(0) > 0 && next_bucket == 1)
        bucket_0 = []
        @arr.count(0).times { bucket_0 << @arr.shift }
        buckets << Bucket.new(0, 0, bucket_0)

        last_bucket = 1
        next_bucket = 2
      end

      # Iterate thorough the remainder of the list in the normal case
      @arr.each_with_index do |e, i|
        break if buckets.length == (@num_buckets - 1)

        if (e >= next_bucket)
          buckets << Bucket.new(last_bucket, next_bucket - 1, @arr[l_index..(i - 1)])

          # Special case here also where all of the results fit into the first bucket
          if buckets[0].contents.length == @arr.length
            l_index = (@arr.length)
            break
          end

          l_index = i
          last_bucket = next_bucket
          next_bucket += @bucket_width

          # Add empty buckets until the next bucket is greater than the current l_index
          while(next_bucket < @arr[l_index])

            buckets << Bucket.new(last_bucket, next_bucket - 1, [])
            last_bucket = next_bucket
            next_bucket += @bucket_width
          end
        end
      end

      # Stuff the remainder into the last bucket
      if(l_index <= (@arr.length - 1))
        buckets << Bucket.new(last_bucket, next_bucket - 1, @arr[l_index..(@arr.length - 1)])
      end

      return buckets
    end

    private
    def get_initial_next_bucket(increments)
      if(@arr[0] != nil && @arr[0] < 0)
        return (@arr[0] + increments)
      elsif(@arr[0] == 0 || @arr[0] == nil)
        return increments
      else
        return increments + @arr[0]
      end
    end

    def remove_elements_outside_of_percentile
      if(@percentile != 100)
        @arr = @arr[0..(@arr.length * (@percentile / 100.0) - 1).to_i]
      end
    end

    def get_bucket_increment
      if(@arr.length == 0)
        return 0
      else
        increment = ((@arr[-1] - @arr[0]) / @num_buckets.to_f).ceil
      end

      return increment
    end

  end
end