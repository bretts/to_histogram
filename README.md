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

        3) [2, 4, 0, 5, 2, 4, 1, 0, 1, 3, 7, 5, 3, 3, 0, 0, 2, 3, 0, 8, 6, 5, 0].to_histogram

        4) That's it

SAMPLE OUTPUT
-------------

my_array.to_histogram
=>

range                frequency              percentage (out of 30)       histogram (percetage) 

423 to 908           | 2                    | 6.6667                         | *******              
909 to 1842          | 5                    | 16.6667                        | *****************    
1843 to 2816         | 4                    | 13.3333                        | *************        
2817 to 3541         | 3                    | 10.0000                        | **********           
3542 to 4339         | 3                    | 10.0000                        | **********           
4340 to 4934         | 1                    | 3.3333                         | ***                  
4935 to 6404         | 3                    | 10.0000                        | **********           
6405 to 7979         | 1                    | 3.3333                         | ***                  
7980 to 8453         | 2                    | 6.6667                         | *******              
8454 to 9525         | 6                    | 20.0000                        | ******************** 