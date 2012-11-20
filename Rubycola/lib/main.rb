require 'manager'

input = gets.chomp
params = input.split

order = params[2..params.length]
man = Manager.new(params[1], order)
man.take_order
puts man.serve_meal