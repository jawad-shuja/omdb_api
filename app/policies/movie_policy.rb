class MoviePolicy
  attr_reader :user, :movie

  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def update?
    user.admin?
  end
end
