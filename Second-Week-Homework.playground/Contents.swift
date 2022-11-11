import Foundation

protocol Values {
    var name: String {get}
    var year: Int {get}
}

enum UserType : Int {
    case jr = 1
    case mid = 2
    case sr = 4
}
enum MaritalStatus{
    case married
    case single
    case widow
}
struct Employee : Values {
    var name: String
    var year: Int
    var type: UserType
    var maritalStatus: MaritalStatus
    var salary: Int {
        return (self.year ) * self.type.rawValue * 1000
    }
    init(name: String, year: Int, type: UserType, maritalStatus: MaritalStatus){
        self.name = name
        self.year = year
        self.type = type
        self.maritalStatus = maritalStatus
    }
}
struct Company : Values {
    var name: String
    var year: Int
    var budget: Int?
    var employees: [Employee] = []
    var totalSalary: Int {
        var salary = 0
        for i in self.employees {
            salary += i.salary
        }
        return salary
    }
    init(name: String, year: Int, budget: Int){
        self.name = name
        self.year = year
        self.budget = budget
    }
    mutating func addEmploye(_ employee : Employee){
        employees.append(employee)
    }
    mutating func addMoneyToBudget(_ money: Int){
        print("\(money)old Budget:\(self.budget ?? 0)")
        self.budget = money + (self.budget ?? 0)
        print("new Budget:\(budget ?? 0)")
    }
    mutating func getMonetFromBudget(_ money: Int){
        print("\(money)old Budget:\(self.budget ?? 0)")
        if let totalMoney = self.budget{
            self.budget = totalMoney - money
        }
        print("new Budget:\(budget ?? 0)")
    }
    
    mutating func paySalary(){
        
        if let money = budget {
            if((money - self.totalSalary) > 0) {
                budget = money - self.totalSalary
            }
            else
            {
                print("Budget is not enough Total Salary:\(self.totalSalary), Budget:\(self.budget ?? 0)")
            }
        }
    }
}

let user = Employee(name: "Ali Rıza", year: 34, type: UserType.sr, maritalStatus: MaritalStatus.married)
let user1 = Employee(name: "Ezgi", year: 21, type: UserType.jr, maritalStatus: MaritalStatus.single)
let user2 = Employee(name: "Furkan", year: 28, type: UserType.mid, maritalStatus: MaritalStatus.single)
let user3 = Employee(name: "Melike", year: 28, type: UserType.mid, maritalStatus: MaritalStatus.married)
let user4 = Employee(name: "Pınar", year: 46, type: UserType.sr, maritalStatus: MaritalStatus.married)
var vakifBank = Company(name: "Vakıf Bank", year: 1950, budget: 46000)

vakifBank.addEmploye(user)
vakifBank.addEmploye(user1)
vakifBank.addEmploye(user2)
vakifBank.addEmploye(user3)
vakifBank.addEmploye(user4)

for i in vakifBank.employees {
    print("User:\(i.name), Salary: \(i.salary), Married: \(i.maritalStatus)")
}
vakifBank.paySalary()
vakifBank.addMoneyToBudget(654324)
vakifBank.paySalary()
//vakifBank.addMoneyToBudget(150231)  CompletionBlock kullanılacak
//vakifBank.getMonetFromBudget(15023) CompletionBlock kullanılacak
// çalışanların yaşlarını ve şirketlerin kuruluş yıllarını düzenle !!!!!


