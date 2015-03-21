module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Kiin"
    end
  end
end
