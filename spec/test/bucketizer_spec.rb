require_relative '../spec_helper'

describe 'Bucketizer' do
    before :all do
        @integer_data = [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0, 6, 1, 9, 3, 7, 8, 6, 0, 2, 6, 2, 4, 2, 4, 1, 1, 3, 0, 5, 0, 7, 4, 9, 8, 5, 1, 8, 0, 8, 5, 8, 5, 8, 3, 2, 7, 9, 7, 7, 5, 3, 7, 0, 1, 4, 4, 3, 7, 2, 2, 2, 1, 4, 5, 3, 4, 6, 4, 1, 8, 4, 0, 5, 4, 3, 3, 0, 9, 8, 5, 9, 9, 0, 5, 2, 7, 0]
    end

    
    describe "percentile" do
        it 'should limit the internal @arr length to the percentile value (default 100%)' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                ]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 100)
            expect(bucketizer.instance_variable_get("@arr").length).to eq(data.length)
        end

        it 'should limit the internal @arr length by using the provided percentile value' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                ]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 90)
            bucketizer.create_buckets

            expected_data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8]

            expect(bucketizer.instance_variable_get("@arr").length).to eq(expected_data.length)
        end            
    end
    
    describe "#increments" do
        it 'should return the increments used by the bucketing' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 100)
            expect(bucketizer.bucket_width).to eq(8832147)
        end

        it 'should take into account percentile when determining increments' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 90)
            expect(bucketizer.bucket_width).to eq(1)
        end

        it 'should allow for and take into account negative numbers' do
            data = [73, 49, -58, -56, -9, -66, 90, 62, 26, -29, -14, 27, -56, 86, 44, -86, 91, 23, 73, 6, 18, 48, 29, -19, -10, -54, 69, 71, 14, -45, -82, 16, 11, -41, -75, -93, -46, -30, 96, -36, 13, 70, 70, 23, -95, -54, -56, 62, -21, 4, 53, -47, -42, 41, -23, -50, -25, -40, -1, -18, -17, 61, -95, -97, -54, -89, -35, 54, 88, 45, 42, 98, 51, 13, 68, -60, 7, 60, -20, 78, 4, 57, -62, -47, 21, 13, 59, 16, -42, 28, 49, 38, 19, 86, 76, -87, 38, 79, 76, -66]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 100)
            expect(bucketizer.bucket_width).to eq(20)
        end
    end

    describe '#bucket_width' do
        it 'should try to determine a width if one is not provided' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 90)
            expect(bucketizer.bucket_width).to eq(1)
        end

        it 'should allow the user to provide their own bucket_width' do
            data = [67,89,81,70,74,28,49,32,46,93,18,5,74,89,13,20,76,29,92,54,64,45,56,77,97,71,39,83,57,20,68,3,12,33,30,35,93,87,72,37,35,98,60,5,58,73,46,13,37,82,18,5,98,38,95,6,68,47,67,99,3,91,20,91,15,31,96,16,18,66,4,6,66,23,46,41,96,35,59,42,11,77,40,11,30,86,45,85,6,98,87,73,41,22,84,56,99,51,42,46,35,62,52,32,86,49,87,29,93,77,1,56,23,93,86,74,37,78,36,9,60,36,29,89,63,54,0,66,29,37,81,55,26,94,64,28,91,45,57,39,53,67,5,60,25,92,64,30,39,70,43,54,18,56,56,2,23,50,11,62,27,55,6,41,10,74,78,31,43,37,83,84,18,73,78,28,28,32,0,50,34,80,63,3,73,95,22,0,33,8,95,48,44,84,22,5,59,85,71,32,86,60,83,70,5,97,56,34,77,7,93,34,32,26,65,10,10,50,80,55,45,9,80,5,36,28,43,6,39,89,95,54,97,68,55,19,11,53,23,18,64,85,11,24,35,45,62,98,59,54,15,41,4,11,3,46,12,21,91,16,72,25,79,76,93,96,72,14,16,58,61,4,50,51,55,88,29,53,36,28,84,62,22,41,94,80,73,40,38,84,67,85,80,71,54,35,72,69,34,85,65,41,71,32,29,75,16,38,39,43,39,50,85,73,49,56,68,99,77,36,55,45,57,78,27,54,56,24,86,38,74,22,16,7,50,8,69,28,28,57,85,21,97,9,64,25,67,90,90,37,35,83,26,6,13,20,79,87,92,58,22,78,11,35,45,13,75,18,5,4,75,82,51,99,72,73,73,54,36,30,88,30,48,29,56,47,3,59,7,68,70,0,49,76,28,46,72,45,44,42,74,30,56,87,49,59,28,80,52,86,63,20,43,8,2,73,77,14,52,84,38,16,62,36,10,94,53,23,78,85,12,84,14,47,51,64,99,64,32,29,94,74,47,4,66,57,85,61,74,0,91,17,26,67,88,1,43,40,89,55,14,67,17,68,64,10,33,80,33,4,79,4,36,96,63,13,8,98,61,88,48,48,93,5,78,13,52,21,42,37,63,94,28,5,63,76,17,18,29,38]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 20, bucket_width: 5, percentile: 100)
            expect(bucketizer.bucket_width).to eq(5)

            buckets = bucketizer.create_buckets
            expect(buckets.length).to eq(20)

            expect(buckets[0].contents).to eq([0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4])
            expect(buckets[10].contents).to eq([50, 50, 50, 50, 50, 50, 51, 51, 51, 51, 52, 52, 52, 52, 53, 53, 53, 53, 54, 54, 54, 54, 54, 54, 54, 54])
            expect(buckets[-1].contents).to eq([95, 95, 95, 95, 96, 96, 96, 96, 97, 97, 97, 97, 98, 98, 98, 98, 98, 99, 99, 99, 99, 99])
        end
    end

    describe "#create_buckets" do
        it 'should return an array of buckets' do
            bucketizer = ToHistogram::Bucketizer.new(@integer_data, num_buckets: 2, percentile: 100)
            buckets = bucketizer.create_buckets

            expect(buckets.length).to eq(2)
        end

        it 'should return the correct number of buckets when the number if very low' do
            bucketizer = ToHistogram::Bucketizer.new(@integer_data, num_buckets: 1, percentile: 100)
            buckets = bucketizer.create_buckets

            expect(buckets.length).to eq(1)
        end

        it 'should return the correct number of buckets all of the data fits into one bucket' do
            a = [0, 0, 0, 0, 0]
            
            bucketizer = ToHistogram::Bucketizer.new(a, num_buckets: 10, percentile: 90)
            buckets = bucketizer.create_buckets

            expect(buckets.length).to eq(1)
        end

        it 'should be capable of creating bucket increments based on a percentile (90th percentile in this case)' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 20, percentile: 90)
            buckets = bucketizer.create_buckets
            expect(buckets.length).to eq(10)

            expect(buckets[0].contents).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
            expect(buckets[1].contents).to eq([1, 1, 1, 1, 1, 1, 1])
            expect(buckets[2].contents).to eq([2, 2, 2, 2, 2, 2])
            expect(buckets[3].contents).to eq([3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3])
            expect(buckets[4].contents).to eq([4, 4, 4, 4, 4, 4, 4])
            expect(buckets[5].contents).to eq([5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5])
            expect(buckets[6].contents).to eq([6, 6, 6, 6])
            expect(buckets[7].contents).to eq([7, 7, 7, 7, 7, 7, 7, 7, 7])
            expect(buckets[8].contents).to eq([8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8])
            expect(buckets[-1].contents).to eq([9, 9, 9, 9, 9, 9, 9, 9])
        end

        it 'should ensure that when the bucket increment is 1, and the first element in the data set is 0, that 0 and 1 do not get grouped together' do
            data = [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0, 6, 1, 9, 3, 7, 8, 6, 0, 2, 6, 2, 4, 2, 4, 1, 1, 3, 0, 5, 0, 7, 4, 9, 8, 5, 1, 8, 0, 8, 5, 8, 5, 8, 3, 2, 7, 9, 7, 7, 5, 3, 7, 0, 1, 4, 4, 3, 7, 2, 2, 2, 1, 4, 5, 3, 4, 6, 4, 1, 8, 4, 0, 5, 4, 3, 3, 0, 9, 8, 5, 9, 9, 0, 5, 2, 7, 0]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 100)
            buckets = bucketizer.create_buckets

            expect(buckets[0].contents).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
            expect(buckets[-1].contents).to eq([9, 9, 9, 9, 9, 9])
        end

        it 'should not crash if the array is empty' do
            bucketizer = ToHistogram::Bucketizer.new([], num_buckets: 10, percentile: 100)
            buckets = bucketizer.create_buckets

            expect(buckets.length).to eq(0)
        end

        it 'should be able to be called numerous times and get the correct output' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                    5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                    9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                    ]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 100)
            
            buckets = bucketizer.create_buckets
            buckets = bucketizer.create_buckets
            buckets = bucketizer.create_buckets
            expect(bucketizer.bucket_width).to eq(8832147)
        end

        it 'should allow for and take into account negative numbers' do
            data = [73, 49, -58, -56, -9, -66, 90, 62, 26, -29, -14, 27, -56, 86, 44, -86, 91, 23, 73, 6, 18, 48, 29, -19, -10, -54, 69, 71, 14, -45, -82, 16, 11, -41, -75, -93, -46, -30, 96, -36, 13, 70, 70, 23, -95, -54, -56, 62, -21, 4, 53, -47, -42, 41, -23, -50, -25, -40, -1, -18, -17, 61, -95, -97, -54, -89, -35, 54, 88, 45, 42, 98, 51, 13, 68, -60, 7, 60, -20, 78, 4, 57, -62, -47, 21, 13, 59, 16, -42, 28, 49, 38, 19, 86, 76, -87, 38, 79, 76, -66]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, percentile: 100)
            buckets = bucketizer.create_buckets
            expect(buckets.length).to eq(10)

            expect(buckets[0].contents).to eq([-97, -95, -95, -93, -89, -87, -86, -82])
            expect(buckets[1].contents).to eq([-75, -66, -66, -62, -60, -58])
            expect(buckets[2].contents).to eq([-56, -56, -56, -54, -54, -54, -50, -47, -47, -46, -45, -42, -42, -41, -40])
            expect(buckets[3].contents).to eq([-36, -35, -30, -29, -25, -23, -21, -20, -19, -18])
            expect(buckets[4].contents).to eq([-17, -14, -10, -9, -1])
            expect(buckets[5].contents).to eq([4, 4, 6, 7, 11, 13, 13, 13, 14, 16, 16, 18, 19, 21])
            expect(buckets[6].contents).to eq([23, 23, 26, 27, 28, 29, 38, 38, 41, 42])
            expect(buckets[7].contents).to eq([44, 45, 48, 49, 49, 51, 53, 54, 57, 59, 60, 61, 62, 62])
            expect(buckets[8].contents).to eq([68, 69, 70, 70, 71, 73, 73, 76, 76, 78, 79])
            expect(buckets[-1].contents).to eq([86, 86, 88, 90, 91, 96, 98])
        end

        it 'should add empty buckets when there are no elements within the current width' do
            data = [0,0,0,0,0,0,0,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,5,5,5,6,6,6,6,7,7,7,8,14,14,14,25,25,25,25,40,40,40,40,41,41,41,41,42,42,42,42,42,43,43,43,44,44,44,45,45,45,46,46,46,46,47,47,47,48,48,48,48,48,48,48,49,50,50,51,51,51,72,76,89,96,98,98,100,100,100,100,101,101,102,102,102,102,102,103,103,103,104,105,105,106,107,107,107,108,108,108,108,109,111,112,112,112,112,112,112,113,113,116,117,118,119,131,217,227,229,229,245]

            bucketizer = ToHistogram::Bucketizer.new(data, num_buckets: 10, bucket_width: 25, percentile: 100)
            buckets = bucketizer.create_buckets
            expect(buckets.length).to eq(10)

            expect(buckets[0].contents).to eq([0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 8, 14, 14, 14])
            expect(buckets[1].contents).to eq([25, 25, 25, 25, 40, 40, 40, 40, 41, 41, 41, 41, 42, 42, 42, 42, 42, 43, 43, 43, 44, 44, 44, 45, 45, 45, 46, 46, 46, 46, 47, 47, 47, 48, 48, 48, 48, 48, 48, 48, 49])
            expect(buckets[2].contents).to eq([50, 50, 51, 51, 51, 72])
            expect(buckets[3].contents).to eq([76, 89, 96, 98, 98])
            expect(buckets[4].contents).to eq([100, 100, 100, 100, 101, 101, 102, 102, 102, 102, 102, 103, 103, 103, 104, 105, 105, 106, 107, 107, 107, 108, 108, 108, 108, 109, 111, 112, 112, 112, 112, 112, 112, 113, 113, 116, 117, 118, 119])
            expect(buckets[5].contents).to eq([131])
            expect(buckets[6].contents).to eq([])
            expect(buckets[7].contents).to eq([])
            expect(buckets[8].contents).to eq([217])
            expect(buckets[9].contents).to eq([227, 229, 229, 245])
        end
    end
end




