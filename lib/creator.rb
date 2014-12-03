module Interactor::Creator
  def self.included(base)    
    base.class_eval do
      include Interactor

      before :create_model_instance
      before :create
      before :validate

      def clazz
        if @class.nil?
          class_name = self.class.name[6..-1]
          @clazz = Object.const_get(class_name)
        end
        @clazz
      end
      
      def create_model_instance
        self.context[clazz.name.underscore.to_sym] = clazz.new(context.to_h)
      end

      def model
        self.context[clazz.name.underscore.to_sym]
      end

      # def model=(value)
      #   self.context[clazz.name.underscore.to_sym] = value
      # end

      def validate ; end

    end
  end
end 
