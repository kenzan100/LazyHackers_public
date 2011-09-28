class HacksScopesController < ApplicationController
  # GET /hacks_scopes
  # GET /hacks_scopes.xml
  def index
    @hacks_scopes = HacksScope.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hacks_scopes }
    end
  end

  # GET /hacks_scopes/1
  # GET /hacks_scopes/1.xml
  def show
    @hacks_scope = HacksScope.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hacks_scope }
    end
  end

  # GET /hacks_scopes/new
  # GET /hacks_scopes/new.xml
  def new
    @hacks_scope = HacksScope.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hacks_scope }
    end
  end

  # GET /hacks_scopes/1/edit
  def edit
    @hacks_scope = HacksScope.find(params[:id])
  end

  # POST /hacks_scopes
  # POST /hacks_scopes.xml
  def create
    @hacks_scope = HacksScope.new(params[:hacks_scope])

    respond_to do |format|
      if @hacks_scope.save
        format.html { redirect_to(hacks_scopes_path, :notice => 'Hacks scope was successfully created.') }
        format.xml  { render :xml => @hacks_scope, :status => :created, :location => @hacks_scope }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hacks_scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hacks_scopes/1
  # PUT /hacks_scopes/1.xml
  def update
    @hacks_scope = HacksScope.find(params[:id])

    respond_to do |format|
      if @hacks_scope.update_attributes(params[:hacks_scope])
        format.html { redirect_to(@hacks_scope, :notice => 'Hacks scope was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hacks_scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hacks_scopes/1
  # DELETE /hacks_scopes/1.xml
  def destroy
    @hacks_scope = HacksScope.find(params[:id])
    @hacks_scope.destroy

    respond_to do |format|
      format.html { redirect_to(hacks_scopes_url) }
      format.xml  { head :ok }
    end
  end
end
