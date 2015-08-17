module BlueprintHumanizer
  class ComponentData

    def initialize(component_data)
      @component_data = component_data
    end

    def data_class
      @component_data.class
    end

    def humanize
      case
      when @component_data.class == String
        ComponentDataString.new(@component_data).humanize
      when @component_data.class == Array 
        ComponentDataArray.new(@component_data).humanize
      when @component_data.class == Hash 
        ComponentDataHash.new(@component_data).humanize
      end
    end

  end
end
