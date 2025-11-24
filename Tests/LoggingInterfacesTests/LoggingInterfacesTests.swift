import Testing
import LoggingInterfaces
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

@Test func example() async throws {
    
    enum LoggingMode {
        case info
        case error
    }
    
    final class MyLogger: Logger {
        
        typealias Message = String
        typealias Mode = LoggingMode
        
        init() {}
        
        func log(_ message: Message, withMode mode: Mode) {
            switch mode {
            case .info:
                print(message)
            case .error:
                FileHandle.standardError.write(Data("\(message)\n".utf8))
            }
        }
        
        func close() throws {
            // -
        }
        
    }
    
    let logger: any Logger<String,LoggingMode> = MyLogger()
    
    logger.log("hello", withMode: .info)
    logger.log("error!", withMode: .error)
    
}
