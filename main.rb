#require 'rubygems'
#require 'bundler/setup'
require_relative 'src/Cromosoma.rb'
require_relative 'src/Fenoma.rb'



individuos = 150
generaciones = 300
tamanoMatriz = 6
fenom = Fenoma.new(individuos, generaciones, tamanoMatriz) 
puts fenom.poblacion.length


for x in 1..generaciones
    puts "En la Generacion #{x} el mejor fue: #{fenom.historial_aptitudes[x-1]}"
end

puts "El mejor cromosoma fue #{fenom.historial_aptitudes.max}"