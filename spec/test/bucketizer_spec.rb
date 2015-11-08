require_relative '../spec_helper'

describe 'Bucketizer' do
    before :all do
        @integer_data = [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0, 6, 1, 9, 3, 7, 8, 6, 0, 2, 6, 2, 4, 2, 4, 1, 1, 3, 0, 5, 0, 7, 4, 9, 8, 5, 1, 8, 0, 8, 5, 8, 5, 8, 3, 2, 7, 9, 7, 7, 5, 3, 7, 0, 1, 4, 4, 3, 7, 2, 2, 2, 1, 4, 5, 3, 4, 6, 4, 1, 8, 4, 0, 5, 4, 3, 3, 0, 9, 8, 5, 9, 9, 0, 5, 2, 7, 0]
    end

    describe "#create_buckets" do
        it 'should return an array of buckets' do
            bucketizer = ToHistogram::Bucketizer.new(@integer_data, 2, 100)
            buckets = bucketizer.create_buckets

            expect(buckets.length).to eq(2)
        end

        it 'should return the correct number of buckets when the number if very low' do
            bucketizer = ToHistogram::Bucketizer.new(@integer_data, 1, 100)
            buckets = bucketizer.create_buckets

            expect(buckets.length).to eq(1)
        end

        it 'should return the correct number of buckets all of the data fits into one bucket' do
            a = [0, 0, 0, 0, 0]
            
            bucketizer = ToHistogram::Bucketizer.new(a, 10, 90)
            buckets = bucketizer.create_buckets

            expect(buckets.length).to eq(1)
        end

        it 'should be capable of creating bucket increments based on a percentile (90th percentile in this case)' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, 20, 90)
            buckets = bucketizer.create_buckets
            expect(buckets.length).to eq(10)

            expect(buckets[0]).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
            expect(buckets[1]).to eq([1, 1, 1, 1, 1, 1, 1])
            expect(buckets[2]).to eq([2, 2, 2, 2, 2, 2])
            expect(buckets[3]).to eq([3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3])
            expect(buckets[4]).to eq([4, 4, 4, 4, 4, 4, 4])
            expect(buckets[5]).to eq([5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5])
            expect(buckets[6]).to eq([6, 6, 6, 6])
            expect(buckets[7]).to eq([7, 7, 7, 7, 7, 7, 7, 7, 7])
            expect(buckets[8]).to eq([8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8])
            expect(buckets[-1]).to eq([9, 9, 9, 9, 9, 9, 9, 9])
        end

        it 'should ensure that when the bucket increment is 1, and the first element in the data set is 0, that 0 and 1 do not get grouped together' do
            data = [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0, 6, 1, 9, 3, 7, 8, 6, 0, 2, 6, 2, 4, 2, 4, 1, 1, 3, 0, 5, 0, 7, 4, 9, 8, 5, 1, 8, 0, 8, 5, 8, 5, 8, 3, 2, 7, 9, 7, 7, 5, 3, 7, 0, 1, 4, 4, 3, 7, 2, 2, 2, 1, 4, 5, 3, 4, 6, 4, 1, 8, 4, 0, 5, 4, 3, 3, 0, 9, 8, 5, 9, 9, 0, 5, 2, 7, 0]

            bucketizer = ToHistogram::Bucketizer.new(data, 10, 100)
            buckets = bucketizer.create_buckets

            expect(buckets[0]).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
            expect(buckets[-1]).to eq([9, 9, 9, 9, 9, 9])
        end

        it 'should not crash if the array is empty' do
            bucketizer = ToHistogram::Bucketizer.new([], 10, 100)
            buckets = bucketizer.create_buckets

            expect(buckets.length).to eq(0)
        end

        it 'should be able to be called numerous times and get the correct output' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, 10, 100)
            
            buckets = bucketizer.create_buckets
            buckets = bucketizer.create_buckets
            buckets = bucketizer.create_buckets
            expect(bucketizer.bucket_increments).to eq(8832147)
        end
    end

    describe "#increments" do
        it 'should return the increments used by the bucketing' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, 10, 100)
            expect(bucketizer.bucket_increments).to eq(8832147)
        end

        it 'should take into account percentile when determining increments' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, 10, 90)
            expect(bucketizer.bucket_increments).to eq(1)
        end
    end

    describe "#initialize" do
        describe "percentile" do
            it 'should limit the internal @arr length to the percentile value (default 100%)' do
                data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

                bucketizer = ToHistogram::Bucketizer.new(data, 10, 100)
                expect(bucketizer.instance_variable_get("@arr").length).to eq(data.length)
            end

            it 'should limit the internal @arr length by using the provided percentile value' do
                data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

                bucketizer = ToHistogram::Bucketizer.new(data, 10, 90)
                bucketizer.create_buckets

                expected_data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8]

                expect(bucketizer.instance_variable_get("@arr").length).to eq(expected_data.length)
            end            
        end
    end

end




