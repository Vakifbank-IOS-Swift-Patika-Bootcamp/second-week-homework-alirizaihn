import Foundation

protocol Values {
    var name: String { get }
}
protocol Employable: Values {
    var employees: [Employee] { get set }
    mutating func addEmploye(_ employee: Employee)
}

enum UserType: String {
    
    case jr
    case mid
    case sr
    
    var multiplier: Int {
        switch self {
        case .jr: return 1
        case .mid: return 2
        case .sr: return 4
        }
    }
}
enum MaritalStatus {
    case married
    case single
    case widow
}
struct Employee: Values {
    var name: String
    var age: Int
    var type: UserType
    var maritalStatus: MaritalStatus
    var salary: Int {
        return (self.age) * self.type.multiplier * 1000
    }
    init(name: String, age: Int, type: UserType, maritalStatus: MaritalStatus) {
        self.name = name
        self.age = age
        self.type = type
        self.maritalStatus = maritalStatus
    }
}
struct Company: Employable {
    var name: String
    var foundationYear: Int
    var budget: Int?
    var employees: [Employee] = []
    var totalSalary: Int {
        var salary = 0
        for i in self.employees {
            salary += i.salary
        }
        return salary
    }
    init(name: String, foundationYear: Int, budget: Int) {
        self.name = name
        self.foundationYear = foundationYear
        self.budget = budget
    }
    mutating func addEmploye(_ employee: Employee) {
        employees.append(employee)
    }
    mutating func addMoneyToBudget(_ money: Int) {
        if money > 0 {
            self.budget = money + (self.budget ?? 0)
            print("Money added, new budget value => \(self.budget ?? 0)")
        } else {
            print("Money couldn't be added, money should be bigger than 0")
        }
    }
    mutating func getMoneyFromBudget(_ money: Int) {
        if money > 0 {
            if let budgetMoney = self.budget {
                if budgetMoney - money >= 0 {
                    self.budget = budgetMoney - money
                    print("Money was taken, new budget value => \(self.budget ?? 0)")
                } else {
                    print("Budget is not enough")
                }
            }
        } else {
            print("Failed. Money should be bigger than 0")
        }
    }
    mutating func paySalary(
        completion: (_ newBudget: String) -> Void, onFailure: (_ errorMessage: String) -> Void
    ) {
        if self.totalSalary > 0 {
            if let budgetMoney = self.budget {
                if budgetMoney - self.totalSalary >= 0 {
                    self.budget = budgetMoney - self.totalSalary
                    completion(
                        "Payment Successful, Paid money => \(self.totalSalary), New budget value => \(self.budget ?? 0)"
                    )
                } else {
                    onFailure("Budget isn't enough")
                }
            } else {
                onFailure("Payment Failed")
            }
        } else {
            onFailure("No salary to be paid")
        }
        
    }
}

let user = Employee(
    name: "Ali Rıza", age: 34, type: UserType.sr, maritalStatus: MaritalStatus.married)
let user1 = Employee(name: "Ezgi", age: 21, type: UserType.jr, maritalStatus: MaritalStatus.single)
let user2 = Employee(
    name: "Furkan", age: 28, type: UserType.mid, maritalStatus: MaritalStatus.single)
let user3 = Employee(
    name: "Melike", age: 28, type: UserType.mid, maritalStatus: MaritalStatus.married)
let user4 = Employee(
    name: "Pınar", age: 46, type: UserType.sr, maritalStatus: MaritalStatus.married)
var vakifBank = Company(name: "Vakıf Bank", foundationYear: 1950, budget: 46000)

//vakifBank.paySalary() { (message) in
//   print("\(message)")
//} onFailure: { message in
//    print("\(message)")
//}
//vakifBank.addEmploye(user)
//vakifBank.addEmploye(user1)
//vakifBank.addEmploye(user2)
//vakifBank.addEmploye(user3)
//vakifBank.addEmploye(user4)
//
//vakifBank.addMoneyToBudget(-654324)
//vakifBank.addMoneyToBudget(1502310)
//vakifBank.getMoneyFromBudget(-15023)
//vakifBank.getMoneyFromBudget(15023)
//
//vakifBank.paySalary() { (message) in
//   print("\(message)")
//} onFailure: { message in
//    print("\(message)")
//}

//======================================================Question2 ============================================

struct ZooKeeper {
    var name: String = ""
    var animals: [Animal] = []
    var experiance: Int = 0
    var id: Int = 0
    var salary: Int {
        return (self.experiance) * (self.animals.count + 1) * 1000
    }
    init(id: Int, name: String, experiance: Int) {
        self.name = name
        self.id = id
        self.experiance = experiance
    }
    mutating func addNewAnimal(_ newAnimal: Animal) {
        self.animals.append(newAnimal)
    }
}
protocol Animal {
    var name: String { get set }
    var sound: String { get set }
    var id: Int { get set }
    var zooKeeper: ZooKeeper? { get set }
    var waterRequirement: Int { get set }
    init()
    mutating func drinkWater()
    mutating func setZooKeeper(zooKeeper: ZooKeeper)
}
extension Animal {
    init(_ id: Int, _ name: String, _ sound: String, _ waterRequirement: Int) {
        self.init()
        self.id = id
        self.name = name
        self.sound = sound
        self.waterRequirement = waterRequirement
    }
    func drinkWater() {
        print("\(self.sound) - \(self.waterRequirement)")
    }
    mutating func setZooKeeper(zooKeeper: ZooKeeper) {
        self.zooKeeper = zooKeeper
    }
}
struct Cat: Animal {
    var id: Int = 0
    var name: String = ""
    var sound: String = ""
    var zooKeeper: ZooKeeper? = nil
    var waterRequirement: Int = 0
    init() {}
    
}
struct Dog: Animal {
    var id: Int = 0
    var name: String = ""
    var sound: String = ""
    var zooKeeper: ZooKeeper? = nil
    var waterRequirement: Int = 0
    init() {}
}
struct Elephant: Animal {
    var id: Int = 0
    var name: String = ""
    var sound: String = ""
    var zooKeeper: ZooKeeper? = nil
    var waterRequirement: Int = 0
    init() {}
    
}
struct Zoo {
    var animals: [Animal] = []
    var zooKeepers: [ZooKeeper] = []
    var waterLimit: Int
    var dailyWaterRequirement: Int {
        var waterRequerement = 0
        for i in self.animals {
            waterRequerement += i.waterRequirement
        }
        return waterRequerement
    }
    var budget: Int?
    var totalSalary: Int {
        var salary = 0
        for i in self.zooKeepers {
            salary += i.salary
        }
        return salary
    }
    init(waterLimit: Int, budget: Int) {
        self.budget = budget
        self.waterLimit = waterLimit
    }
    mutating func addMoneyToBudget(_ money: Int) {
        if money > 0 {
            self.budget = money + (self.budget ?? 0)
            print("Money added, new budget value => \(self.budget ?? 0)")
        } else {
            print("Money couldn't be added, money should be bigger than 0")
        }
    }
    mutating func getMoneyFromBudget(_ money: Int) {
        if money > 0 {
            if let budgetMoney = self.budget {
                if budgetMoney - money >= 0 {
                    self.budget = budgetMoney - money
                    print("Money was taken, new budget value => \(self.budget ?? 0)")
                } else {
                    print("Budget is not enough")
                }
            }
        } else {
            print("Failed. Money should be bigger than 0")
        }
    }
    mutating func addWater(_ water: Int) {
        if water > 0 {
            self.waterLimit = water + (self.waterLimit)
            print("Water added, new water value => \(self.waterLimit)")
        } else {
            print("Water couldn't be added, Water value should be bigger than 0")
        }
    }
    mutating func serveWater() {
        if self.waterLimit - self.dailyWaterRequirement >= 0 {
            for var i in self.animals {
                i.drinkWater()
            }
            self.waterLimit -= self.dailyWaterRequirement
        } else {
            print("Water is not enough")
        }
    }
    mutating func paySalary() {
        if self.totalSalary > 0 {
            if let budgetMoney = self.budget {
                if budgetMoney - self.totalSalary >= 0 {
                    self.budget = budgetMoney - self.totalSalary
                    print(
                        "Payment Successful, Paid money => \(self.totalSalary), New budget value => \(self.budget ?? 0)"
                    )
                } else {
                    print("Budget isn't enough")
                }
            } else {
                print("Payment Failed")
            }
        } else {
            print("No salary to be paid")
        }
        
    }
    mutating func addZookeeper(_ newZooKeeper: ZooKeeper) {
        if self.zooKeepers.filter({ $0.id == newZooKeeper.id }).count > 0 {
            print("The id is used \(newZooKeeper.id)")
        } else {
            self.zooKeepers.append(newZooKeeper)
        }
        
    }
    mutating func addAnimal(_ newAnimal: Animal) {
        
        if self.zooKeepers.count > 0 {
            if self.animals.filter({ $0.id == newAnimal.id }).count > 0 {
                print("The id is used \(newAnimal.id)")
            } else {
                var animal = newAnimal
                var index = Int.random(in: 0..<zooKeepers.count)
                animal.setZooKeeper(zooKeeper: self.zooKeepers[index])
                self.zooKeepers[index].addNewAnimal(newAnimal)
                self.animals.append(animal)
            }
        } else {
            print("Failed, There are not zookeeper")
        }
    }
}
var Hapsuruk = Cat(1, "Hapsuruk", "miyavvv", 23)
var Ted = Dog(2, "Ted", "Havv", 35)
var Far = Dog(3, "Far", "HdadAavv", 41)
var Knock = Dog(4, "Knock", "dasd", 42)
var FilNecati = Elephant(5, "Necati", "Hiiilçgd", 70)

var Bakici = ZooKeeper(id: 1, name: "Furkan", experiance: 5)
var Bakici2 = ZooKeeper(id: 2, name: "Taner", experiance: 2)
var Bakici3 = ZooKeeper(id: 3, name: "Emre", experiance: 1)

var ankaraZoo = Zoo(waterLimit: 400, budget: 421312)
ankaraZoo.addZookeeper(Bakici)
ankaraZoo.addZookeeper(Bakici2)
ankaraZoo.addZookeeper(Bakici3)
ankaraZoo.addAnimal(Far)

ankaraZoo.addAnimal(Knock)

ankaraZoo.addAnimal(Hapsuruk)
ankaraZoo.serveWater()
ankaraZoo.paySalary()
var Carsq = Elephant(6, "Carsq", "Hiiilçgd", 70)
ankaraZoo.addAnimal(Carsq)
//ankaraZoo.serveWater()
//ankaraZoo.serveWater()
//ankaraZoo.serveWater()
//ankaraZoo.serveWater()
//ankaraZoo.paySalary()
//ankaraZoo.addAnimal(Knock)
//ankaraZoo.addAnimal(Far)
//ankaraZoo.addWater(1231)
//ankaraZoo.getMoneyFromBudget(1990320)

