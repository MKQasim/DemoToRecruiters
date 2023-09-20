
public class Services{
    private init(){}
    public static func doGreatings(greeting: String)->String{
        print("Greeting \(greeting)")
        return "Answer: Walikum slaam! Hello How are you."
    }
    public static func getResources()->UIImage?{
        return UIImage(named: "MindValley")
    }
    
  
}
