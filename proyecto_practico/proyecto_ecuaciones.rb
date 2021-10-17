#require 'rubygems'
#require 'bundler/setup'
require_relative 'Cromosoma.rb'
require_relative 'Fenoma.rb'




generaciones = 25
fenom = Fenoma.new(150, generaciones, 6) #El primer parametro: N. individuos poblacion, El segundo: N. generaciones, El tercero: tamano N matriz
puts fenom.poblacion.length

for x in 0..5
puts fenom.poblacion[55].genes[x].alelo
end

for x in 1..generaciones
    puts "En la Generacion #{x+1} el mejor fue: #{fenom.historial_aptitudes[x]}"
end


#puts fenom.matriz_problema
#puts fenom.vector_problema

=begin
puts "En main matriz: #{fenom.matriz_problema} y vector: #{fenom.vector_problema}"

puts fenom.sumatoriaCuadratico(fenom.producto_Mtz_Vcr([[9, 1], [9, 8]], [0.952380, -0.571428]), [8, 4])*-1
puts fenom.sumatoriaCuadratico(fenom.producto_Mtz_Vcr([[2, 1], [3, 4]], [0.4, 0.2]), [1, 2])*-1
#puts fenom.sumatoriaCuadratico(fenom.producto_Mtz_Vcr([[0, 2], [5, 8]], [1, 7]), [8, 6])
#puts fenom.calcular_Aptitud([1, 7, 3, 5, 4])

puts rand(-10.0..10.0)
puts 3.abs

puts rand(-10..10)


#cromosomas [1, 2] y [3, 4]
genes_prog1 = [Gen.new(1), Gen.new(2), Gen.new(5), Gen.new(2)]
genes_prog2 = [Gen.new(3), Gen.new(4), Gen.new(7), Gen.new(4)]
ale_prog1 = [1, 2, 5, 2]
ale_prog2 = [3, 4, 7, 4]
progs = [Cromosoma.new(genes_prog1, fenom.calcular_Aptitud(ale_prog1)), Cromosoma.new(genes_prog2, fenom.calcular_Aptitud(ale_prog2))]
hijo1 = fenom.realizar_Cruce(progs, 4)
hijo2 = fenom.realizar_Cruce(progs, 4)
hijos = [hijo1, hijo2]
for y in 0..1
    for x in 0..3
        puts "Crom #{y} Gen: #{hijos[y].genes[x].alelo}"
    end
end
=end



#croms = [Cromosoma.new([1, 2, 3], 7), Cromosoma.new([1, 2, 3], 9), Cromosoma.new([1, 2, 3], 3)]
#puts fenom.obtener_Mejor(croms).aptitud

#puts fenom.producto_Mtz_Vcr([[7, 3, 3],[1, 2, 4],[2, 6, 1]], [2, 3, 5])

#puts fenom.sumatoriaCuadratico([2, 3, 4], [1, 7, 5])