require_relative './bucketizer'

module ToHistogram

  class Histogram
    include Enumerable

    def initialize(array, num_buckets: 10, bucket_width: 'auto', percentile: 100)
      bucketizer      = Bucketizer.new(array, num_buckets: num_buckets, bucket_width: bucket_width, percentile: percentile)
      
      @buckets        = bucketizer.create_buckets
      @bucket_width   = bucketizer.bucket_width
      @percentile     = percentile
      @num_buckets    = num_buckets
    end
    attr_reader :percentile, :num_buckets, :bucket_width, :buckets

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

    def bucket_contents_length
      @buckets.reduce(0) { |sum, x| sum + x.contents.length }
    end

    def bucket_contents_values
      a = []
      @buckets.map { |b| a << b.contents }
      return a.flatten
    end

    def inspect
      return "class: #{self.class} object_id: #{self.object_id}"
    end

  end
end