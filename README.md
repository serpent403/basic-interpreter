START PROGRAM:
--------------
ruby basic_interpreter.rb


GENERAL INFO:
--------------
Simple interpreter which tells us current value of a variable, if its not defined then value should be zero, Input starts with ‘[‘ and will end with matching ‘]’
 
 Sample Input:
 [
 a 10
 print a
 b 20
 [
 a 10
 print a 
 print b
 b 23
 print b
 b a
 print b
 b 23
 ]
 print a
 print b
 print c
 ]

 Sample output
 10
 10
 20
 23
 10
 10
 20
 0


 Sample Input
 [
 print a
 ]

 Sample Output
 0








