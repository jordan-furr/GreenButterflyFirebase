//
//  HabitController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

class HabitController {
    
    static let shared = HabitController()
    
    var defaultHabits: [Habit] = [
        Habit(title: "Refill Waterbottle", iconUID: "bottle", co2Value: 0.083, identifier: 0, source: "https://sciencing.com/carbon-footprint-plastic-bottle-12307187.html", fact: "Globally, humans now purchase 1 million single-use waterbottles a minute."),
        Habit(title: "Meatless Day", iconUID: "vegetarian", co2Value: 2.495, identifier: 1, source: "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2535638/", fact: "One 1/4 lb. of beef requires 425 gallons of water to produce."),
        Habit(title: "Vegan Day", iconUID: "vegan", co2Value: 3.629, identifier: 2, source: "https://blogs.ei.columbia.edu/2018/12/27/35-ways-reduce-carbon-footprint/", fact: "Meat and dairy are responsible for 14.5% of global green house gas emissions."),
        Habit(title: "Laundry w/ cold water", iconUID: "machine", co2Value: 0.714, identifier: 3, source: "https://www.coldwatersaves.org/", fact: "Water heating can account for up to 90 percent of the total energy use in a hot water wash cycle"),
        Habit(title: "Mile not driven", iconUID: "bike", co2Value: 0.435, identifier: 4, source: "https://www.transit.dot.gov/sites/fta.dot.gov/files/docs/PublicTransportationsRoleInRespondingToClimateChange2010.pdf", fact: "Walking and biking have zero co2 emission rates!!!"),
        Habit(title: "Public transit (bus)", iconUID: "bus", co2Value: 0.353, identifier: 5, source: "https://www.transit.dot.gov/sites/fta.dot.gov/files/docs/PublicTransportationsRoleInRespondingToClimateChange2010.pdf", fact: "Taking public transport could lower your carbon footprint by 2177kgs annually."),
        Habit(title: "Public transit (train)", iconUID: "train", co2Value: 0.390, identifier: 6, source: "https://www.transit.dot.gov/sites/fta.dot.gov/files/docs/PublicTransportationsRoleInRespondingToClimateChange2010.pdf", fact: "Taking public transport could lower your carbon footprint by 2177kgs annually."),
        Habit(title: "Air dried clothing", iconUID: "clothes", co2Value: 3.109, identifier: 7, source: "https://www.greenamerica.org/green-living/ditch-your-dryer", fact: "80% of the carbon footprint of the clothes we buy comes from washing and drying alone."),
        Habit(title: "No food waste day", iconUID: "trash", co2Value: 1.096, identifier: 8, source: "http://shrinkthatfootprint.com/the-big-footprint-of-food-waste", fact: "Consumer food waste is responsible for around 10% of global Green House Gas emissions."),
        Habit(title: "Used reusable bag", iconUID: "bag", co2Value: 0.232, identifier: 9, source: "https://digitalcommons.morris.umn.edu/cgi/viewcontent.cgi?article=1002&context=urs_2017", fact: "Reusable bags need to be used at least 11 times to have a lower impact than single-use plastic bags "),
        Habit(title: "Reusable coffee cup", iconUID: "coffee", co2Value: 0.323, identifier: 10, source: "https://www.officeclimatesolutions.com/the-carbon-cost-of-coffee-cups.html", fact: "It would only take 25 people switching from single-use coffee cups to reusable ones to save 1 ton of co2 each year!"),
        Habit(title: "Borrowed book", iconUID: "book", co2Value: 2.710, identifier: 11, source: "https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1530-9290.2011.00414.x", fact: "For every 400,000 books produced, 1084 tonnes of co2 is released"),
        Habit(title: "Buy used clothing", iconUID: "reuse", co2Value: 5.9, identifier: 12, source: "https://gaiaandglobalwarming.wordpress.com/about/re-using-clothes-saves-co2/", fact: "If every American bought          just one used item instead of new, it would be equivalent to removing half a million cars off the road for a year!"),
        Habit(title: "Printed double-sided", iconUID: "paper", co2Value: 0.009, identifier: 13, source: "https://www.standardcarbon.com/2008/06/do-you-really-need-to-print-that-the-carbon-footprint-of-copy-paper", fact: "Paper also has huge costs on trees and deforestation so printing double sided is always a great choice."),
        Habit(title: "Composted", iconUID: "compost", co2Value: 0.010, identifier: 14, source: "https://journals.sagepub.com/doi/abs/10.1177/0734242X08088584?casa_token=BX7SBaW8xCMAAAAA%3AisCu0S3McLvH9ebdQ71mxC8heXx3Aokix0SJTXWfIwFAzD-STY7GGsnNNQQP9hz9AfvcUMaOLqs&", fact: "Composting helps reduce the production of methane from decomposing food. Compost is said to sequester between 0.1 - 1.0 ton of co2 so we gave this actions a low estimate."),
        Habit(title: "Took the stairs", iconUID: "elevator", co2Value: 0.178, identifier: 15, source: "https://hr.umich.edu/sites/default/files/green-facts-%202015.pdf", fact: "An individual generates about 6.5 kg of carbon emissions per year by taking the elevator. That works out to half a metric ton of carbon emissions over a lifetime"),
        Habit(title: "Recycled can", iconUID: "can", co2Value: 0.126, identifier: 16, source: "https://alupro.org.uk/industry/local-authorities/environmental-benefits/", fact: "Recycling aluminium uses 95% less energy than producing aluminium from raw materials."),
        Habit(title: "Recycled glass", iconUID: "glass", co2Value: 0.079, identifier: 17, source: "https://www.carbonfootprint.com/recycling.html", fact: "Reducing the number of things that need to be thrown away, reduces the amount of materials which have to be quarried and mined."),
        Habit(title: "Recycled cardboard", iconUID: "cardboard", co2Value: 0.142, identifier: 16, source: "https://recoverusa.com/environmental-impact-of-recycling-cardboard/", fact: "For every ton of cardboard recycled, about 17 trees are saved."),
        Habit(title: "Recycled plastic", iconUID: "plastic", co2Value: 0.581, identifier: 17, source: "https://stanfordmag.org/contents/the-link-between-plastic-use-and-climate-change-nitty-gritty", fact: "Recycling and re-manufacturing plastic saves at least 30 percent of the carbon emissions that original processing and manufacturing produces.")
    ]
 
    var enabledHabits: [Habit] = []
    var enabledCounts: [Int] = []
    var disabledHabits: [Habit] = []
    

    
    func fetchUserHabits(){
        guard let user = UserController.shared.currentUser else {return}
        enabledHabits = []
        disabledHabits = []
        enabledCounts = []
        
        let allHabits = defaultHabits
        for i in 0..<allHabits.count {
            if user.enabled[i]{
                enabledHabits.append(allHabits[i])
                enabledCounts.append(user.counts[i])
            } else {
                disabledHabits.append(allHabits[i])
            }
        }
    }
    
    func toggleHabit(habit: Habit){
        guard let user = UserController.shared.currentUser,
            let index = defaultHabits.firstIndex(of: habit) else {return}
        
        user.enabled[index] = !user.enabled[index]
        let data = ["enabled" : user.enabled]
        UserController.shared.updateUserData(userID: user.id, data: data)
        fetchUserHabits()
    }
    
    func incrementHabitCounter(habit: Habit) -> Int{
        guard let user = UserController.shared.currentUser else {return 0}
        
        user.counts[habit.identifier] = user.counts[habit.identifier] + 1
        let data = ["counts" : user.counts]
        UserController.shared.updateUserData(userID: user.id, data: data)
        fetchUserHabits()
        return user.counts[habit.identifier]
    }
    
    func decrementHabitCounter(habit: Habit) -> Int{
        guard let user = UserController.shared.currentUser else {return 0}
        
        user.counts[habit.identifier] = user.counts[habit.identifier] - 1
        let data = ["counts" : user.counts]
        UserController.shared.updateUserData(userID: user.id, data: data)
        fetchUserHabits()
        return user.counts[habit.identifier]
    }
    
    func getUsertotalCO2() -> Double {
        guard let user = UserController.shared.currentUser else {return 0}
        var total: Double =  0
        for habit in defaultHabits {
            let habitTotal = habit.co2Value * Double(user.counts[habit.identifier])
            total = total + habitTotal
        }
        return total
    }
}
