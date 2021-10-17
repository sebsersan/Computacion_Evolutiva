#Clase que modela un gen del cromosoma. Este es, en realidad, un valor del vector solucion "s" al sistema de ecuaciones As = B

class Gen

    attr_accessor :alelo

    def initialize(alelo_recibido)
        @alelo = alelo_recibido
    end

end

