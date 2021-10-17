#Clase que modela el entorno y su interaccion con los cromosomas (o viceversa)
require_relative 'Gen.rb'
require_relative 'Cromosoma.rb'


class Fenoma

    attr_accessor :poblacion, :matriz_problema, :vector_problema, :vector_solucion, :historial_aptitudes, :N
    
    def initialize(numero_individuos, numero_generaciones, valor_N)
        @historial_aptitudes = []
        @poblacion = []
        @N = valor_N
        @matriz_problema = generar_Matriz(valor_N)
        @vector_solucion = generar_Vector(valor_N)
        @vector_problema = producto_Mtz_Vcr(matriz_problema, vector_solucion)
        iniciar_evolucion(numero_individuos, numero_generaciones, valor_N)
        
    end

#------------------------------------------------------------------------------------------------------------
    def iniciar_evolucion(numero_individuos, numero_generaciones, tamano_N)
        generar_Poblacion_Inicial(numero_individuos, tamano_N)
        poblacion_nueva = []
        progenitores = []
        for generaciones in 1..numero_generaciones 
            #puts "Generacion N. #{generaciones} :::::::::::::::::::::::::::::::::::::::"
            @historial_aptitudes.push obtener_Mejor(@poblacion).aptitud
            poblacion_nueva = [] #Esta linea permite dos tipos de poblacion: sin ella, la vieja poblacion se reemplaza con nueva; con ella, se mezclan
            for individuos_nuevos in 1..numero_individuos
                progenitores.push desarrollar_Torneo(numero_individuos)
                progenitores.push desarrollar_Torneo(numero_individuos)
                hijo_1 = realizar_Cruce(progenitores, tamano_N)
                hijo_2 = realizar_Cruce(progenitores, tamano_N)
                mutacion_1 = mutar_Cromosoma(hijo_1, tamano_N, hijo_1.aptitud)
                mutacion_2 = mutar_Cromosoma(hijo_2, tamano_N, hijo_2.aptitud)
                seleccion = obtener_Mejor([mutacion_1, mutacion_2])
                poblacion_nueva.push seleccion
                progenitor = []
                #puts "Crom #{individuos_nuevos} Aptt: #{seleccion.aptitud}"
            end
            @poblacion = poblacion_nueva
        end
    end

#------------------------------------------------------------------------------------------------------------
    def generar_Poblacion_Inicial(numero_individuos, tamano_N)
        for x in 1..numero_individuos
            @poblacion.push generar_Cromosoma(tamano_N)
        end
    end
#------------------------------------------------------------------------------------------------------------
    #Aqui se lleva a cabo el proceso de SLECCION de cromosomas
    def desarrollar_Torneo(numero_individuos)
        cromosoma_iter = []
        progenitor = nil
        for x in 1..0.03*numero_individuos #Cuantos individuos se escogen para competir, variar para observar resultados
            cromosoma_iter.push @poblacion[rand(numero_individuos)]
        end
        progenitor = obtener_Mejor(cromosoma_iter) #se obtiene un progenitor del torneo
        return progenitor
    end

#------------------------------------------------------------------------------------------------------------
    def realizar_Cruce(progenitores, tamano_N)
        genes_hijo = []
        alelos_iter = []
        for x in 0..tamano_N-1
            genes_hijo.push progenitores[rand(2)].genes[x]
            alelos_iter.push genes_hijo[x].alelo
        end
        cromosoma_hijo = Cromosoma.new(genes_hijo, calcular_Aptitud(alelos_iter))
        return cromosoma_hijo
    end

#------------------------------------------------------------------------------------------------------------
    def mutar_Cromosoma(cromosoma, tamano_N, aptitud_padre)
        posicion = rand(tamano_N)
        cromosoma.genes[posicion].alelo = generar_Num(false, aptitud_padre, cromosoma.genes[posicion].alelo)
        return cromosoma
    end

#------------------------------------------------------------------------------------------------------------
    def generar_Cromosoma(tamano_N)
        genes_iter = []
        alelos_iter = []
        for x in 0..tamano_N-1
            genes_iter.push Gen.new(generar_Num(true,0,0))
            alelos_iter.push genes_iter[x].alelo
        end
        cromosoma_iter = Cromosoma.new(genes_iter, calcular_Aptitud(alelos_iter))
        return cromosoma_iter
    end

#------------------------------------------------------------------------------------------------------------
    def obtener_Mejor(cromosomas)
        mejor_cromosoma = cromosomas[0]
        if (cromosomas.length>1)
            for x in 0..cromosomas.length-2
                if (cromosomas[x+1].aptitud > mejor_cromosoma.aptitud)
                    mejor_cromosoma = cromosomas[x+1]
                end
            end
        end
        return mejor_cromosoma
    end

#------------------------------------------------------------------------------------------------------------
    #Genera una matriz de manera aleatoria
    def generar_Matriz(tamano_N)
        fila_iter = []
        matriz_iter = []
        for fila in 1..tamano_N #Columnas
            for columna in 1..tamano_N #Filas
                fila_iter.push generar_Num(true,0,0)
            end
            matriz_iter.push fila_iter
            fila_iter = []
        end
        return matriz_iter
    end

#------------------------------------------------------------------------------------------------------------
    #Genera un vector de manera aleatoria
    def generar_Vector(tamano_N)
        vector_iter = []
        for x in 1..tamano_N
            vector_iter.push generar_Num(true,0,0)
        end
        return vector_iter
    end

#------------------------------------------------------------------------------------------------------------
    def generar_Num(entero,aptitud_progenitor, valor_a_mutar)
        if (entero)
            aleatorio = rand(-10.0..10.0).round(1)
            return aleatorio
        else
            aptitud_por_valor =(aptitud_progenitor/(@N*@N*@N)).round(2)

            min_range = (valor_a_mutar-aptitud_por_valor.abs).round(2)
            max_range = (valor_a_mutar+aptitud_por_valor.abs).round(2)

            mutacion = rand(min_range..max_range).round(2)
            #print("Mutacion: #{mutacion}\r\n")
            return mutacion
        end
    end

#------------------------------------------------------------------------------------------------------------
    #Funcion que calcula la aptitud siguiendo la formula del error cuadratico
    def calcular_Aptitud(alelos)
        return diff_vectors(alelos).round(2)
        #vector_R = producto_Mtz_Vcr(@matriz_problema, alelos)
        #return (sumatoriaCuadratico(vector_R, @vector_problema) * -1).round(2)
    end

#------------------------------------------------------------------------------------------------------------
    #Esta es una funcion auxiliar en el calculo de la aptitud que tiene que ver con el error cuadratico
    def sumatoriaCuadratico(vectorR, vectorB)
        if (vectorR.length==1)
            return (vectorR[0]-vectorB[0]) ** 2
        else
            return ((vectorR[0]-vectorB[0]) ** 2) + sumatoriaCuadratico((vectorR.slice 1, vectorR.length), (vectorB.slice 1, vectorB.length))
        end
    end

#------------------------------------------------------------------------------------------------------------
    #Metodo que multiplica una matriz con un vector
    def producto_Mtz_Vcr(matriz, vector)
        vector_iter = []
        for fila in 0..vector.length-1
            vector_iter.push multiplicar_Vectores(matriz[fila], vector)
        end
        return vector_iter
    end

#------------------------------------------------------------------------------------------------------------
    def multiplicar_Vectores(vector1, vector2)
        if (vector1.length==1)
            return vector1[0] * vector2[0]
        else
            return (vector1[0]*vector2[0]) + multiplicar_Vectores((vector1.slice 1, vector1.length), (vector2.slice 1, vector2.length))
        end
    end
#------------------------------------------------------------------------------------------------------------
def diff_vectors(alelos)
    aptitud = 0
    for x in 0..@N-1
        aptitud = aptitud - (vector_solucion[x]-alelos[x]).abs
    end

    return aptitud 
end
#------------------------------------------------------------------------------------------------------------
end
