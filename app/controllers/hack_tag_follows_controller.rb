class HackTagFollowsController < ApplicationController
  # GET /hack_tag_follows
  # GET /hack_tag_follows.xml
  def index
    @hack_tag_follows = HackTagFollow.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hack_tag_follows }
    end
  end

  # GET /hack_tag_follows/1
  # GET /hack_tag_follows/1.xml
  def show
    @hack_tag_follow = HackTagFollow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hack_tag_follow }
    end
  end

  # GET /hack_tag_follows/new
  # GET /hack_tag_follows/new.xml
  def new
    @hack_tag_follow = HackTagFollow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hack_tag_follow }
    end
  end

  # GET /hack_tag_follows/1/edit
  def edit
    @hack_tag_follow = HackTagFollow.find(params[:id])
  end

  # POST /hack_tag_follows
  # POST /hack_tag_follows.xml
  def create
    @hack_tag_follow = HackTagFollow.new(params[:hack_tag_follow])

    respond_to do |format|
      if @hack_tag_follow.save
        format.html { redirect_to(new_hack_tag_follow_path, :notice => 'Hack tag follow was successfully created.') }
        format.xml  { render :xml => @hack_tag_follow, :status => :created, :location => @hack_tag_follow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hack_tag_follow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hack_tag_follows/1
  # PUT /hack_tag_follows/1.xml
  def update
    @hack_tag_follow = HackTagFollow.find(params[:id])

    respond_to do |format|
      if @hack_tag_follow.update_attributes(params[:hack_tag_follow])
        format.html { redirect_to(@hack_tag_follow, :notice => 'Hack tag follow was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hack_tag_follow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hack_tag_follows/1
  # DELETE /hack_tag_follows/1.xml
  def destroy
    @hack_tag_follow = HackTagFollow.find(params[:id])
    @hack_tag_follow.destroy

    respond_to do |format|
      format.html { redirect_to(hack_tag_follows_url) }
      format.xml  { head :ok }
    end
  end
end
