/// A logger, logging messages.
/// The `Mode` is primarily there to
/// choose a rendering mode which visually might
/// differentiate e.g. between a normal information
/// and an error, it does not have
/// to represent all message types (which might
/// better be part of the `Message` type).
/// If the mode is not given, a default mode should
/// be used.
@available(*, deprecated, message: "this package is deprecated, use the repository https://github.com/swiftxml/LoggingInterfaces instead and note the version number being reset to 1.0.0")
public protocol Logger<Message,Mode>: Sendable {
    
    associatedtype Message: Sendable, CustomStringConvertible
    associatedtype Mode: Sendable
    
    /// Log a message.
    func log(_ message: Message, withMode mode: Mode?)
    
    /// Close the logger. This ensures
    /// that all messages have been logged.
    func close() throws
    
}

/// This mode does not differentiate.
public enum IndifferentLoggingMode: Sendable {
    case indifferent
}

/// This mode is for printing to the console.
public enum PrintMode: Sendable {
    case standard
    case error
}

/// This is a logger that can be used to "merge" several other loggers,
/// i.e. all messages are being distributed to all loggers.
///
/// The use is limited because all loggers have to
/// understand the same logging mode.
@available(*, deprecated, message: "this package is deprecated, use the repository https://github.com/swiftxml/LoggingInterfaces instead and note the version number being reset to 1.0.0")
public final class MultiLogger<Message: Sendable & CustomStringConvertible,Mode>: Logger {

    public typealias Message = Message
    public typealias Mode = Mode
    
    private let _loggers: [any Logger<Message,Mode>]
    
    public var loggers: [any Logger<Message,Mode>] { _loggers }
    
    public init(_ loggers: [any Logger<Message,Mode>]) {
        self._loggers = loggers
    }
    
    public convenience init(_ loggers: any Logger<Message,Mode>...) {
        self.init(loggers)
    }
    
    public func log(_ message: Message, withMode mode: Mode? = nil) {
        _loggers.forEach { logger in
            logger.log(message, withMode: mode)
        }
    }
    
    public func close() throws {
        try _loggers.forEach { logger in
            try logger.close()
        }
    }
}
