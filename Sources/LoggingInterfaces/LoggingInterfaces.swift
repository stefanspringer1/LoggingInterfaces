/// A logger, logging messages.
/// The `Mode` is primarily there to
/// choose a rendering mode which visually might
/// differentiate e.g. between a normal information
/// and an error, it does not have
/// to represent all message types (which might
/// better be part of the `Message` type).
public protocol Logger<Message,Mode>: Sendable {
    
    associatedtype Message: Sendable, CustomStringConvertible
    associatedtype Mode: Sendable
    
    /// Log a message.
    func log(_ message: Message, withMode mode: Mode)
    
    /// Close the logger. This ensures
    /// that all messages have been logged.
    func close() throws
    
}
