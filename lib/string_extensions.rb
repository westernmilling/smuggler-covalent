# StringExtensions
module StringExtensions
  refine String do
    # "Brute force" underscore the string.
    # Removes any non-alpha characters for clean symbol ready strings.
    def brute_underscore
      gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .gsub(/([\\][\"])/, '')
        .gsub(/([\t])/, ' ')
        .tr('-', '_')
        .tr(' ', '_')
        .squeeze('_')
        .downcase
    end
  end
end
