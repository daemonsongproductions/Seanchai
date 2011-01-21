class PseudoUser < User

  def after_initialize
    self.id = -1
    self.user_type = UserType.reader
  end

  def save
    raise PseudoUserException, "PseudoUsers cannot be saved."
  end

  def delete
    raise PseudoUserException, "PseudoUsers cannot be deleted."
  end


end

class PseudoUserException < RuntimeError

end