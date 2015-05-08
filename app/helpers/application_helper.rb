module ApplicationHelper
  def full_title page_title = ''
    base_title = "Framgia E-Learning System"
    if page_title.empty?
      base_title
    else 
      "#{page_title} | #{base_title}"
    end
  end

  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new 
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder) 
    end
    
    link_to(name, "javascript:void(0);", onclick: h("add_fields(this, \"#{id}\",
      \"#{escape_javascript(fields)}\")"))    
  end
  
  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, '#',onclick: "remove_fields(this)")  
  end  
end