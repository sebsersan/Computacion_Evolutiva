#Clase que modela la estructura de los cromosomas

class Cromosoma

    attr_accessor :genes, :aptitud

    def initialize(genes_recibidos, aptitud_recibida)
        @genes = genes_recibidos
        @aptitud = aptitud_recibida
    end

end

