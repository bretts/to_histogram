require_relative './bucketizer'

module ToHistogram

  class Histogram
    include Enumerable

    def initialize(array, num_buckets: 10, bucket_width: nil, percentile: 100)
      bucketizer      = Bucketizer.new(array, num_buckets: num_buckets, bucket_width: bucket_width, percentile: percentile)
      @buckets        = bucketizer.create_buckets
      @bucket_widths  = bucketizer.bucket_widths
      @percentile     = percentile
      @num_buckets    = num_buckets
    end
    attr_reader :percentile, :num_buckets, :bucket_widths, :buckets

    def each(&block)
      @buckets.each do |b|
        yield b
      end
    end

    def [](i)
      return @buckets[i]
    end

    def length
      return @buckets.length
    end

    def inspect
      return "class: #{self.class} object_id: #{self.object_id}"
    end

  end
end