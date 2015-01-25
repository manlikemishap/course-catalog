module SearchHelper

  def pre_fall
    Date.today.month >= 3 && Date.today.month <= 9
  end

  def pre_spring
    !pre_fall
  end

end
