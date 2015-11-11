module ToHistogram
    class Bucket

        def initialize(from, to, contents)
            @from       = from
            @to         = to
            @contents   = contents
        end
        attr_reader :from, :to, :contents

        def inspect
            puts "#{self.class}: @from: #{@from}, @to: #{@to}, @contents: #{@contents.class}"
        end
    end
end