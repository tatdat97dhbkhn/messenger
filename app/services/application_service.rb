class ApplicationService
  attr_reader :payload, :errors

  class << self
    def parameter(name)
      attr_reader name

      @parameters ||= []
      @parameters << name.to_sym
    end

    def parameters(*params)
      params.each do |param|
        parameter(param)
      end
    end

    def call(**params)
      new(**params).tap(&:call)
    end
  end

  def initialize(**params)
    @payload ||= ''
    @errors ||= []

    set_parameters(params)
  end

  def set_parameters(params)
    params.each do |param_name, param_value|
      instance_variable_set("@#{param_name}", param_value)
    end
  end

  def logger
    @logger ||= Rails.logger
  end

  def fail?
    errors.any?
  end

  def success?
    !fail?
  end

  private_class_method :new
end
