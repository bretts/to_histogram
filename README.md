ToHistogram
===========

PURPOSE
-------
The purpose of this program is allow the user to print out a quick histogram distribution from an array when running an irb session

FEATURES
--------
Adds #to_histogram to Array

EXAMPLE USAGE
-------------
        1) gem install to_histogram

        2) require 'to_histogram'

        3) [2,4,0,5,2,4,1,0,1,3,7,5,3,3,0,0,2,3,0,8,6,5,0,10,11,12].to_histogram

        4) That's it

MORE USAGE
-------------
        1) You can change the percentile that the histogram displays by modifying the percentile keyword argument (default is 100%).
        For example, let's say you have a data set that consists of mostly of values between 0 and 9 with a few results > 1,000,000

            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462]

            To see an even bucket size across all values you would just do data.to_histogram. However, if you wanted to see what was going on
            in the 90th percentile, you can also do a data.to_histogram(percentile: 90)
