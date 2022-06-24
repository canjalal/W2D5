class Flight
    attr_reader :passengers
    def initialize(flightnum, capacity)
        @flight_number = flightnum
        @capacity = capacity
        @passengers = []
    end

    def full?
        @passengers.size == @capacity
    end

    def board_passenger(pasajero)
        @passengers << pasajero if (!self.full? && pasajero.has_flight?(@flight_number))
    end

    def list_passengers
        @passengers.map(&:name)
    end

    def [](idx)
        @passengers[idx]
    end

    def <<(pasajero)
        self.board_passenger(pasajero)
    end
end