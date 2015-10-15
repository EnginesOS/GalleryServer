class UserHomesController < ApplicationController

  before_action :authenticate_user!

end