module ApplicationHelper
  
  def print_flash_message
    if flash[:notice].presence
      raw "<div style='color:#006F00; margin:10px 0;'>#{flash[:notice]}</div>"
    elsif flash[:errors].presence
      raw "<div style='color:#AD0000; margin:10px 0;'>#{flash[:errors]}</div>"
    end
  end

  def get_my_errors(obj = nil)
    arr = []
    arr = obj.errors.values.flatten if obj
    arr.join('<br/>')
  end
  
end