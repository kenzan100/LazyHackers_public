class UsersHacktagsController < ApplicationController
  # GET /users_hacktags
  # GET /users_hacktags.xml
  def index
    @users_hacktags = UsersHacktag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users_hacktags }
    end
  end

  # GET /users_hacktags/1
  # GET /users_hacktags/1.xml
  def show
    @users_hacktag = UsersHacktag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @users_hacktag }
    end
  end

  # GET /users_hacktags/new
  # GET /users_hacktags/new.xml
  def new
    @users_hacktag = UsersHacktag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users_hacktag }
    end
  end

  # GET /users_hacktags/1/edit
  def edit
    @users_hacktag = UsersHacktag.find(params[:id])
  end

  # POST /users_hacktags
  # POST /users_hacktags.xml
  def create
    @users_hacktag = UsersHacktag.new(params[:users_hacktag])

    respond_to do |format|
      if @users_hacktag.save
        format.html { redirect_to(@users_hacktag, :notice => 'Users hacktag was successfully created.') }
        format.xml  { render :xml => @users_hacktag, :status => :created, :location => @users_hacktag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @users_hacktag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users_hacktags/1
  # PUT /users_hacktags/1.xml
  def update
    @users_hacktag = UsersHacktag.find(params[:id])

    respond_to do |format|
      if @users_hacktag.update_attributes(params[:users_hacktag])
        format.html { redirect_to(@users_hacktag, :notice => 'Users hacktag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @users_hacktag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users_hacktags/1
  # DELETE /users_hacktags/1.xml
  def destroy
    @users_hacktag = UsersHacktag.find(params[:id])
    @users_hacktag.destroy

    respond_to do |format|
      format.html { redirect_to(users_hacktags_url) }
      format.xml  { head :ok }
    end
  end
end
