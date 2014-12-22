module Interactor::Creator
  def self.included(base)    
    base.class_eval do
      include Interactor

      # before :initialize_model_instance
      before :build
      # before :create
      before :after_build
      before :validate

      def after_build ; end

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

      def create ; end

      def base_params
        context.to_h.except(context_key)
      end

      def build
        self.context[context_key] = klazz.new(build_params)
      end

      def build_params
        base_params
      end
      
      # def initialize_model_instance
      #   build
      #   # self.context[context_key] = klazz.new(build_params)
      # end

      def model
        context[context_key]
      end

      # def model=(value)
      #   self.context[clazz.name.underscore.to_sym] = value
      # end

      # Prevalidate the new model before attempting to persist.
      def validate 
        unless model.valid?
          context.fail!(:message => 'Invalid details')
        end
      end

    end
  end
end 
