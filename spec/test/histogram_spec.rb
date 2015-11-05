require_relative '../spec_helper'

describe 'Histogram' do
    before :all do
        @integer_data = [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0, 6, 1, 9, 3, 7, 8, 6, 0, 2, 6, 2, 4, 2, 4, 1, 1, 3, 0, 5, 0, 7, 4, 9, 8, 5, 1, 8, 0, 8, 5, 8, 5, 8, 3, 2, 7, 9, 7, 7, 5, 3, 7, 0, 1, 4, 4, 3, 7, 2, 2, 2, 1, 4, 5, 3, 4, 6, 4, 1, 8, 4, 0, 5, 4, 3, 3, 0, 9, 8, 5, 9, 9, 0, 5, 2, 7, 0]
    end
    
    describe "#each" do
        it 'should yield arrays' do
            histogram = ToHistogram::Histogram.new(@integer_data, 10)
            
            histogram.each { |a| expect(a.class).to eq Array }
        end
    end

    describe "#[]" do
        it 'should return an array at the index' do
            histogram = ToHistogram::Histogram.new(@integer_data, 10)
            
            expect(histogram[0]).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        end
    end

    describe "#length" do
        it 'should return the number of buckets' do
            histogram = ToHistogram::Histogram.new(@integer_data, 2)

            expect(histogram.length).to eq(2)
        end
    end
end