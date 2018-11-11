
/*
 This is where you will be getting your data from a different source.
 */

import UIKit

class Data {
    
    static func getData(completion: @escaping ([Model]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            var data = [Model]()
            data.append(Model(title: "Finish Home Screen", subTitle: "Web App", image: [], data1: "8", data2: "AM"))
            data.append(Model(title: "Lunch Break", subTitle: "", image: [], data1: "11", data2: "AM"))
            data.append(Model(title: "Design Standup", subTitle: "Hangouts", image: getImages(), data1: "2", data2: "PM"))
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    static func getImages() -> [UIImage]{
        var images = [UIImage]()
        images.append(#imageLiteral(resourceName: "pp1"))
        images.append(#imageLiteral(resourceName: "pp2"))
        images.append(#imageLiteral(resourceName: "pp3"))
        return images
    }
    static func getDayWeather(completion: @escaping (DayWeatherModel?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let data = DayWeatherModel(dayName:"Monday", longDate:"February 8, 2015" , temperature: "58°", city:"San Fransico" , weatherIcon:#imageLiteral(resourceName: "sun"))
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
}
