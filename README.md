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

        3) [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0, 14, 11, 13, 15, 16].to_histogram(num_buckets: 10)

        4) That's it
