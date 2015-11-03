require_relative '../spec_helper'

describe 'Bucketizer' do
    before :all do
        @integer_data = [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0, 6, 1, 9, 3, 7, 8, 6, 0, 2, 6, 2, 4, 2, 4, 1, 1, 3, 0, 5, 0, 7, 4, 9, 8, 5, 1, 8, 0, 8, 5, 8, 5, 8, 3, 2, 7, 9, 7, 7, 5, 3, 7, 0, 1, 4, 4, 3, 7, 2, 2, 2, 1, 4, 5, 3, 4, 6, 4, 1, 8, 4, 0, 5, 4, 3, 3, 0, 9, 8, 5, 9, 9, 0, 5, 2, 7, 0]
    end

    describe "#create_buckets" do
        it 'should return an array of buckets' do
            bucketizer = ToHistogram::Bucketizer.new
            buckets = bucketizer.create_buckets(@integer_data, 2)

            expect(buckets.length).to eq(2)
        end

        it 'should return the correct number of buckets when the number if very low' do
            bucketizer = ToHistogram::Bucketizer.new
            buckets = bucketizer.create_buckets(@integer_data, 1)

            expect(buckets.length).to eq(1)
        end

        it 'should return the correct number of buckets all of the data fits into one bucket' do
            a = [5018, 5898, 8127]
            
            bucketizer = ToHistogram::Bucketizer.new
            buckets = bucketizer.create_buckets(a, 10)

            expect(buckets.length).to eq(1)
        end
    end
end