require_relative '../spec_helper'

describe 'Bucketizer' do
    before :all do
        @integer_data = [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0, 6, 1, 9, 3, 7, 8, 6, 0, 2, 6, 2, 4, 2, 4, 1, 1, 3, 0, 5, 0, 7, 4, 9, 8, 5, 1, 8, 0, 8, 5, 8, 5, 8, 3, 2, 7, 9, 7, 7, 5, 3, 7, 0, 1, 4, 4, 3, 7, 2, 2, 2, 1, 4, 5, 3, 4, 6, 4, 1, 8, 4, 0, 5, 4, 3, 3, 0, 9, 8, 5, 9, 9, 0, 5, 2, 7, 0]
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

        it 'should allow for and take into account negative numbers' do
            data = [73, 49, -58, -56, -9, -66, 90, 62, 26, -29, -14, 27, -56, 86, 44, -86, 91, 23, 73, 6, 18, 48, 29, -19, -10, -54, 69, 71, 14, -45, -82, 16, 11, -41, -75, -93, -46, -30, 96, -36, 13, 70, 70, 23, -95, -54, -56, 62, -21, 4, 53, -47, -42, 41, -23, -50, -25, -40, -1, -18, -17, 61, -95, -97, -54, -89, -35, 54, 88, 45, 42, 98, 51, 13, 68, -60, 7, 60, -20, 78, 4, 57, -62, -47, 21, 13, 59, 16, -42, 28, 49, 38, 19, 86, 76, -87, 38, 79, 76, -66]

            bucketizer = ToHistogram::Bucketizer.new(data, 10, 100)
            expect(bucketizer.bucket_increments).to eq(20)
        end
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

        it 'should allow for and take into account negative numbers' do
            data = [73, 49, -58, -56, -9, -66, 90, 62, 26, -29, -14, 27, -56, 86, 44, -86, 91, 23, 73, 6, 18, 48, 29, -19, -10, -54, 69, 71, 14, -45, -82, 16, 11, -41, -75, -93, -46, -30, 96, -36, 13, 70, 70, 23, -95, -54, -56, 62, -21, 4, 53, -47, -42, 41, -23, -50, -25, -40, -1, -18, -17, 61, -95, -97, -54, -89, -35, 54, 88, 45, 42, 98, 51, 13, 68, -60, 7, 60, -20, 78, 4, 57, -62, -47, 21, 13, 59, 16, -42, 28, 49, 38, 19, 86, 76, -87, 38, 79, 76, -66]

            bucketizer = ToHistogram::Bucketizer.new(data, 10, 100)
            buckets = bucketizer.create_buckets
            expect(buckets.length).to eq(10)

            expect(buckets[0]).to eq([-97, -95, -95, -93, -89, -87, -86, -82])
            expect(buckets[1]).to eq([-75, -66, -66, -62, -60, -58])
            expect(buckets[2]).to eq([-56, -56, -56, -54, -54, -54, -50, -47, -47, -46, -45, -42, -42, -41, -40])
            expect(buckets[3]).to eq([-36, -35, -30, -29, -25, -23, -21, -20, -19, -18])
            expect(buckets[4]).to eq([-17, -14, -10, -9, -1])
            expect(buckets[5]).to eq([4, 4, 6, 7, 11, 13, 13, 13, 14, 16, 16, 18, 19, 21])
            expect(buckets[6]).to eq([23, 23, 26, 27, 28, 29, 38, 38, 41, 42])
            expect(buckets[7]).to eq([44, 45, 48, 49, 49, 51, 53, 54, 57, 59, 60, 61, 62, 62])
            expect(buckets[8]).to eq([68, 69, 70, 70, 71, 73, 73, 76, 76, 78, 79])
            expect(buckets[-1]).to eq([86, 86, 88, 90, 91, 96, 98])
        end
    end

end




