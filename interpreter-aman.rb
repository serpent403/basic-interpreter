class BasicInterpreter
  def initialize
    @input = [] # array of user input elements, eg: ["[", "a 10", "print a", "]"]
    @data_stack = [] # data stack controlled by scope of square brackets
  end

  # start the job
  def start
    info # information for the user to go through first
    read # read user input
    parse # parse and evaluate user input
  end

  # read user input into memory
  def read
    puts "You can start typing:"
    fwd_sq_brkt = 0 # number of '[' brackets entered by the user
    bwd_sq_brkt = 0 # number of ']' brackets entered by the user
    while(true)
      i = gets.chop.downcase.strip
      if i == ''
        next
      end
      @input << i
      unless @input.first == "["
        puts "[ERROR] Input must start with '[' and end with ']'"
        exit
      end
      if i == "[" # if forward bracket then increment it by one
        fwd_sq_brkt +=1
      elsif i == "]" # if backward bracket then increment it by one
        bwd_sq_brkt +=1
        break if fwd_sq_brkt == bwd_sq_brkt
      end
    end
  end

  # parse the user input
  def parse
    h = {} # contains current data being processed
    @input.each do |i|
      if i == '['
        # save the current state of data hash (h) in the @data_stack
        @data_stack.push(h.dup) unless h.empty? #there is data to push onto the stack
      elsif i == ']'
        h = @data_stack.pop || {} # pop out latest data hash (h) stored in the @data_stack
      else
        evaluate_command(i, h) # note: h -> pass by refrence
      end
    end
  end

  # Execute the command(eg : "a 10" , "print a", "b a") and update the data hash (h) accordingly
  # i -> command to be evaluated
  # h -> current data on the stack
  def evaluate_command(i, h)
    cmd = i.split(/\s/) # split by whitespace. Equivalent to [\t\n\r\f].
    cmd.delete("") # remove empty string elements that might come up due to extra spaces in the command
    if(cmd[0].include?('print')) # encountered print command
      puts fetch_value(cmd, h)
    else
      h[cmd[0].to_sym] = fetch_value(cmd, h)
    end
  end
 
  # fetch value of variable/constant to right of the 2 word command
  # eg: value of in command "print b" or "a b". b can be a constant number/variable
  def fetch_value(cmd, h)
    if(h[cmd[1].to_sym] == nil) # data not available in hash (h)
      begin
        v = eval(cmd[1].to_s) || 0 # it's a number
      rescue Exception => e
        v = 0 # it's an undefined variable
      end
    else
      v =  h[cmd[1].to_sym] #fetch the variable content from data hash (h)
    end
    return v
  end

  # information for the user to go through first
  def info
    puts %Q{
        Input must start with '[' and end with matching ']'
        Please make sure that you follow the format specified in the sample input(shown below) while entering data.

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
    }
  end


end

BasicInterpreter.new.start

