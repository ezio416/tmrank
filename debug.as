
// Logging helper functions
namespace Logger {

    // Print to console when in dev mode
    void DevMessage(const string&in message) {
        if(Meta::IsDeveloperMode()) {
            print(message);
        }
    }

    // Raise a fatal error
    void Error(const string&in message) {
        throw(message);
    }
}