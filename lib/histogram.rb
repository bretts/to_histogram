require_relative './bucketizer'

module ToHistogram

  class Histogram
    include Enumerable

    def initialize(array, num_buckets)
      bucketizer  = Bucketizer.new(array, num_buckets)
      @buckets    = bucketizer.create_buckets
    end

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

  end
end