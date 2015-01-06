# Base field translation behavior
module FieldTranslation
  extend ActiveSupport::Concern

  SENDER_FIELD_KEY = :sender

  included do
    scope :by_sender, ->(sender) { where(:sender_value => sender) }

    validates_presence_of :sender_value

    class << self
      def translate(hash)
        by_sender(hash[SENDER_FIELD_KEY]).each do |translation|
          next unless translation.match?(hash)

          return FieldTranslation::TranslationResult.success(
            translation.get_value(hash))
        end

        FieldTranslation::TranslationResult.fail(self, hash)
      end
    end

    def get_value(*)
      fail 'get_value must be defined'
    end

    def match?(*)
      fail 'match? must be defined'
    end
  end

  # The result of a field translation attempt.
  class TranslationResult
    attr_accessor :success, :message, :value

    class << self
      def fail(klass, hash_values)
        result = TranslationResult.new
        result.success = false
        result.message = I18n.t(
          'default.error',
          :name => klass.name.underscore.humanize[0..-13].downcase,
          :purchase_order_number => hash_values[:po_number],
          :line_number => hash_values[:line_nbr],
          :scope => :field_translation)
        result
      end

      def success(value)
        result = TranslationResult.new
        result.success = true
        result.value = value
        result
      end
    end
  end
end
