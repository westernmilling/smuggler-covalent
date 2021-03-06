require 'string_extensions'

module HashExtensions
  refine Hash do
    using StringExtensions

    # Recursively converts CamelCase and camelBack JSON-style hash keys to
    # Rubyish snake_case, suitable for use during instantiation of Ruby
    # model attributes.
    #
    def to_snake_keys(value = self)
      case value
      when Array
        value.map { |v| to_snake_keys(v) }
      when Hash
        Hash[value.map { |k, v| [underscore_key(k), to_snake_keys(v)] }]
      else
        value
      end
    end

    private

    def underscore_key(k)
      if k.is_a? Symbol
        underscore(k.to_s).to_sym
      elsif k.is_a? String
        underscore(k)
      else
        k # Plissken can't snakify anything except strings and symbols
      end
    end

    def underscore(string)
      string.brute_underscore
    end
  end
end
