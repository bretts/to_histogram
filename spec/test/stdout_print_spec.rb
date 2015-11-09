require 'stringio'
require_relative '../spec_helper'

describe "StdoutPrint" do

    describe "#invoke" do
        it 'should be able to display histograms using default options' do
            output          = StringIO.new
            data            = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462]

            histogram       = ToHistogram::Histogram.new(data, num_buckets: 10, percentile: 100)    
            stdout_print    = ToHistogram::StdoutPrint.new(histogram, data, output)
            stdout_print.invoke

            STDOUT.puts output.string
            expected_output = "\n**************************************************************\nResults for #to_histogram(num_buckets: 10, percentile: 100, print_info: true)\n\nData set used in this calculation \nData set Size: 100 items\nMin Value: 0, Max Value: 88321462\nMean: 5612112, Median: 5, Mode: 3\n\nHistogram bucket sizes: 8832147\n**************************************************************\n\nRange                Frequency              Percentage                   Histogram (each * =~ 1%) \n\n0 to 9932834         | 90                   | 90.0000                        | ****************************************************************************************** \n9932834 to 41335782  | 1                    | 1.0000                         | *                    \n41335782 to 43423001 | 1                    | 1.0000                         | *                    \n43423001 to 46295572 | 1                    | 1.0000                         | *                    \n46295572 to 52671287 | 1                    | 1.0000                         | *                    \n52671287 to 68025842 | 1                    | 1.0000                         | *                    \n68025842 to 68036186 | 1                    | 1.0000                         | *                    \n68036186 to 72884833 | 2                    | 2.0000                         | **                   \n72884833 to 88321462 | 1                    | 1.0000                         | *                    \n88321462 to 88321462 | 1                    | 1.0000                         | *                    \n"  
            expect(output.string).to eq(expected_output)
        end

        it 'should be able to display histograms for different percentiles' do
            output          = StringIO.new
            data            = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462]

            histogram       = ToHistogram::Histogram.new(data, num_buckets: 10, percentile: 90)    
            stdout_print    = ToHistogram::StdoutPrint.new(histogram, data, output)
            stdout_print.invoke

            STDOUT.puts output.string
            expected_output = "\n**************************************************************\nResults for #to_histogram(num_buckets: 10, percentile: 90, print_info: true)\n\nData set used in this calculation (Numbers limited to the 90th percentile)\nData set Size: 90 items\nMin Value: 0, Max Value: 9\nMean: 4, Median: 5, Mode: 3\n\nHistogram bucket sizes: 1\n**************************************************************\n\nRange                Frequency              Percentage                   Histogram (each * =~ 1%) \n\n0 to 1               | 10                   | 11.1111                        | ***********          \n1 to 2               | 7                    | 7.7778                         | ********             \n2 to 3               | 6                    | 6.6667                         | *******              \n3 to 4               | 15                   | 16.6667                        | *****************    \n4 to 5               | 7                    | 7.7778                         | ********             \n5 to 6               | 13                   | 14.4444                        | **************       \n6 to 7               | 4                    | 4.4444                         | ****                 \n7 to 8               | 9                    | 10.0000                        | **********           \n8 to 9               | 11                   | 12.2222                        | ************         \n9 to 9               | 8                    | 8.8889                         | *********            \n"
            expect(output.string).to eq(expected_output)
        end

        it 'should be able to display histograms for negative and positive values' do
            output          = StringIO.new
            data            = data = [73, 49, -58, -56, -9, -66, 90, 62, 26, -29, -14, 27, -56, 86, 44, -86, 91, 23, 73, 6, 18, 48, 29, -19, -10, -54, 69, 71, 14, -45, -82, 16, 11, -41, -75, -93, -46, -30, 96, -36, 13, 70, 70, 23, -95, -54, -56, 62, -21, 4, 53, -47, -42, 41, -23, -50, -25, -40, -1, -18, -17, 61, -95, -97, -54, -89, -35, 54, 88, 45, 42, 98, 51, 13, 68, -60, 7, 60, -20, 78, 4, 57, -62, -47, 21, 13, 59, 16, -42, 28, 49, 38, 19, 86, 76, -87, 38, 79, 76, -66]

            histogram       = ToHistogram::Histogram.new(data, num_buckets: 10, percentile: 100)    
            stdout_print    = ToHistogram::StdoutPrint.new(histogram, data, output)
            stdout_print.invoke

            STDOUT.puts output.string
            expected_output = "\n**************************************************************\nResults for #to_histogram(num_buckets: 10, percentile: 100, print_info: true)\n\nData set used in this calculation \nData set Size: 100 items\nMin Value: -97, Max Value: 98\nMean: 5, Median: 13, Mode: -56\n\nHistogram bucket sizes: 20\n**************************************************************\n\nRange                Frequency              Percentage                   Histogram (each * =~ 1%) \n\n-97 to -75           | 8                    | 8.0000                         | ********             \n-75 to -56           | 6                    | 6.0000                         | ******               \n-56 to -36           | 15                   | 15.0000                        | ***************      \n-36 to -17           | 10                   | 10.0000                        | **********           \n-17 to 4             | 5                    | 5.0000                         | *****                \n4 to 23              | 14                   | 14.0000                        | **************       \n23 to 44             | 10                   | 10.0000                        | **********           \n44 to 68             | 14                   | 14.0000                        | **************       \n68 to 86             | 11                   | 11.0000                        | ***********          \n86 to 98             | 7                    | 7.0000                         | *******              \n"
            expect(output.string).to eq(expected_output)
        end
    end
end