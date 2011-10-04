class PartiesHacktagsController < ApplicationController
  def index
    @parties_hacktags = PartiesHacktag.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end