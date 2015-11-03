module ToHistogram

    class Bucketizer

        def create_buckets(array, num_buckets)
          arr                   = array.sort
          bucket_increments     = (arr[-1].to_f) / num_buckets  
          l_index               = 0
          next_bucket           = bucket_increments
          buckets               = []
          
          arr.each_with_index do |e, i|
            if !(e <= next_bucket)
              buckets << arr[l_index..(i - 1)]

              # Special case where all of the results fit into the first bucket
              if buckets[0].length == arr.length
                l_index = (arr.length - 1)
                break
              end

              l_index = i
              next_bucket += bucket_increments
            end
          end

          if(l_index != (arr.length - 1))
            buckets << arr[l_index..(arr.length - 1)]
          end

          return buckets
        end

    end
end