module BlueprintHumanizer
  class ComponentDataArray

    def initialize(array)
      @array = array
    end

    def humanize
      @array.map{ |component_data| "<li>#{ ComponentData.new(component_data).humanize }</li>" }.join()
    end

  end
end