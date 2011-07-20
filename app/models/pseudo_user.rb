class PseudoUser < User

  after_initialize :setup_user

  def setup_user
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