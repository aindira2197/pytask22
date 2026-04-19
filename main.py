class Vehicle:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model

    def info(self):
        return f"Brand: {self.brand}, Model: {self.model}"

class Car(Vehicle):
    def __init__(self, brand, model, year):
        super().__init__(brand, model)
        self.year = year

    def info(self):
        return f"Brand: {self.brand}, Model: {self.model}, Year: {self.year}"

class Truck(Vehicle):
    def __init__(self, brand, model, capacity):
        super().__init__(brand, model)
        self.capacity = capacity

    def info(self):
        return f"Brand: {self.brand}, Model: {self.model}, Capacity: {self.capacity} tons"

class Motorcycle(Vehicle):
    def __init__(self, brand, model, engine_size):
        super().__init__(brand, model)
        self.engine_size = engine_size

    def info(self):
        return f"Brand: {self.brand}, Model: {self.model}, Engine size: {self.engine_size} cc"

class VehicleFactory:
    @staticmethod
    def create_vehicle(vehicle_type, brand, model, **kwargs):
        if vehicle_type == "car":
            return Car(brand, model, kwargs["year"])
        elif vehicle_type == "truck":
            return Truck(brand, model, kwargs["capacity"])
        elif vehicle_type == "motorcycle":
            return Motorcycle(brand, model, kwargs["engine_size"])

class Garage:
    def __init__(self):
        self.vehicles = []

    def add_vehicle(self, vehicle):
        self.vehicles.append(vehicle)

    def display_vehicles(self):
        for vehicle in self.vehicles:
            print(vehicle.info())

garage = Garage()
car = VehicleFactory.create_vehicle("car", "Toyota", "Corolla", year=2015)
truck = VehicleFactory.create_vehicle("truck", "Mercedes", "Actros", capacity=40)
motorcycle = VehicleFactory.create_vehicle("motorcycle", "Honda", "CBR500R", engine_size=500)

garage.add_vehicle(car)
garage.add_vehicle(truck)
garage.add_vehicle(motorcycle)

garage.display_vehicles()