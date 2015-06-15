class GeographicGroup < Group

  field :coordinates, :type => Array
  field :radius, :type => Float

  def in_group(user_to_check)
    raise NotImplementedError
  end

end