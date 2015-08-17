module BlueprintHumanizer
  class Component

    def initialize(component_name, component_data)
      @component_name = component_name.titleize
      @component_data = component_data
    end

    def humanize
      if @component_data.present?
        "<div>".html_safe + humanized_components + "</div>".html_safe
      end
    end

    def humanized_components
      data = ComponentData.new(@component_data)
      data_class = data.data_class
      if data_class == String && data
        "<label>".html_safe  + @component_name + 
        "</label> <div class='data_string'>".html_safe + 
        data.humanize + "</div>".html_safe
      elsif data_class == Array && data
        "<label>".html_safe + @component_name + "</label>
         <ul>#{ data.humanize }</ul>".html_safe 
      elsif data_class == Hash && data
        "<label>".html_safe + @component_name + "</label>
         <ul>#{data.humanize}</ul>".html_safe
      end
    end

  end
end
