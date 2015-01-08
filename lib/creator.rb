module Interactor::Creator
  def self.included(base)
    base.class_eval do
      include Interactor

      before :build
      before :after_build
      before :validate

      def after_build; end

      def klazz
        if @klazz.nil?
          class_name = self.class.name[6..-1]
          @klazz = Object.const_get(class_name)
        end
        @klazz
      end

      def context_key
        klazz.name.gsub(/(::)/, '').underscore.to_sym
      end

      def create_with_params
        context.to_h
      end

      def create; end

      def base_params
        context.to_h.except(context_key)
      end

      def build
        context[context_key] = klazz.new(build_params)
      end

      def build_params
        base_params
      end

      def model
        context[context_key]
      end

      # Prevalidate the new model before attempting to persist.
      def validate
        return if model.valid?
        
        context.fail!(:message => 'Invalid details')
      end
    end
  end
end
