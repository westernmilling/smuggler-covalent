module Interactor::Creator
  def self.included(base)    
    base.class_eval do
      include Interactor

      before :initialize_model_instance
      before :create
      before :validate

      def clazz
        if @class.nil?
          class_name = self.class.name[6..-1]
          @clazz = Object.const_get(class_name)
        end
        @clazz
      end

      def create_with_params
        context.to_h
      end

      def create ; end
      
      def initialize_model_instance
        self.context[clazz.name.underscore.to_sym] = clazz.new(create_with_params)
      end

      def model
        self.context[clazz.name.underscore.to_sym]
      end

      # def model=(value)
      #   self.context[clazz.name.underscore.to_sym] = value
      # end

      # Prevalidate the new model before attempting to persist.
      def validate ; end

    end
  end
end 
