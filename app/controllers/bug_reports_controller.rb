class BugReportsController < ApplicationController

  def create
    render text: params
  end

end