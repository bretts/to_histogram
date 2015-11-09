ToHistogram
===========

PURPOSE
-------
The purpose of this program is to take an array of integers and return a histogram distribution for it. The program also prints out a quick histogram distribution with some info to stdout if desired.

FEATURES
--------
Adds #to_histogram to Array

EXAMPLE USAGE
-------------
        1) gem install to_histogram

        2) require 'to_histogram'

        3) histogram = [2,4,0,5,2,4,1,0,1,3,7,5,3,3,0,0,2,3,0,8,6,5,0,10,11,12].to_histogram

        4) That's it

MORE USAGE
-------------
        1) You can change the percentile that the histogram displays by modifying the percentile keyword argument (default is 100%).
        For example, let's say you have a data set that consists of mostly of values between 0 and 9 with a few results > 1,000,000

            data = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9932834,41335782,43423001,46295572,52671287,68025842,68036186,70284069,72884833,88321462]

            To see an even bucket size across all values you would just do data.to_histogram. However, if you wanted to see what was going on
            in the 90th percentile, you can also do a data.to_histogram(percentile: 90)

        2) If you don't want to see the printed info and just want to get the histogram object, do the following: 
            histogram = [2,4,0,5,2,4,1,0,1,3,7,5,3,3,0,0,2,3,0,8,6,5,0,10,11,12].to_histogram(print_info: false)

            histogram.each do |bucket|
                puts bucket.length
            end

        3) You can specify your own bucket width if you like. If you don't specify one, to_histogram will try to determine one for you.
            data = [67,89,81,70,74,28,49,32,46,93,18,5,74,89,13,20,76,29,92,54,64,45,56,77,97,71,39,83,57,20,68,3,12,33,30,35,93,87,72,37,35,98,60,5,58,73,46,13,37,82,18,5,98,38,95,6,68,47,67,99,3,91,20,91,15]

            data.to_histogram(num_buckets: 20, bucket_width: 5)

