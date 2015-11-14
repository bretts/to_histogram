require_relative '../spec_helper'

# Add more tests in here... just a basic validation
describe 'ToHistogram' do
   
    describe "to_histogram" do
        it 'not crash' do
            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,
                5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,
                9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462
                ]

            data.to_histogram
        end
    end
end




