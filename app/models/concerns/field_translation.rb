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
          return translation.get_value(hash) if translation.match?(hash)
        end

        return nil
      end
    end

    def get_value(*)
      fail 'get_value must be defined'
    end

    def match?(*)
      fail 'match? must be defined'
    end
  end
end
