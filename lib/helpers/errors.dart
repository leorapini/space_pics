// Simple implementation to differentiate between errors derived from
// external API (i.e. ServerError from NASA api) or local ones (i.e. 
// LocalError derived from corruped json file).
class ServerError implements Exception {}

class LocalError implements Exception {}