import Foundation

@main
enum IncBuildNumber {
    static func main() {
        guard let infoFile = ProcessInfo.processInfo.environment["INFOPLIST_FILE"] else { return }
        guard let projectDir = ProcessInfo.processInfo.environment["SRCROOT"] else { return }
        
        if var dict = NSDictionary(contentsOfFile: projectDir + "/" + infoFile) as? [String: Any],
           ProcessInfo.processInfo.environment["CONFIGURATION"] == "Release" {
            guard let currentBuildNumberString = dict["CFBundleVersion"] as? String,
                  let currentBuildNumber = Int(currentBuildNumberString) else { return }
            dict["CFBundleVersion"] = "\(currentBuildNumber + 1)"
            
            (dict as NSDictionary).write(toFile: projectDir + "/" + infoFile, atomically: true)
        }
    }
}
