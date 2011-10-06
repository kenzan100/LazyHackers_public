class PartiesScopesController < ApplicationController
  # GET /parties_scopes
  # GET /parties_scopes.xml
  def index
    @parties_scopes = PartiesScope.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parties_scopes }
    end
  end

  # GET /parties_scopes/1
  # GET /parties_scopes/1.xml
  def show
    @parties_scope = PartiesScope.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @parties_scope }
    end
  end

  # GET /parties_scopes/new
  # GET /parties_scopes/new.xml
  def new
    @parties_scope = PartiesScope.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @parties_scope }
    end
  end

  # GET /parties_scopes/1/edit
  def edit
    @parties_scope = PartiesScope.find(params[:id])
  end

  # POST /parties_scopes
  # POST /parties_scopes.xml
  def create
    @parties_scope = PartiesScope.new(params[:parties_scope])

    respond_to do |format|
      if @parties_scope.save
        format.html { redirect_to(@parties_scope, :notice => 'Parties scope was successfully created.') }
        format.xml  { render :xml => @parties_scope, :status => :created, :location => @parties_scope }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @parties_scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /parties_scopes/1
  # PUT /parties_scopes/1.xml
  def update
    @parties_scope = PartiesScope.find(params[:id])

    respond_to do |format|
      if @parties_scope.update_attributes(params[:parties_scope])
        format.html { redirect_to(@parties_scope, :notice => 'Parties scope was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @parties_scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parties_scopes/1
  # DELETE /parties_scopes/1.xml
  def destroy
    @parties_scope = PartiesScope.find(params[:id])
    @parties_scope.destroy

    respond_to do |format|
      format.html { redirect_to(parties_scopes_url) }
      format.xml  { head :ok }
    end
  end
end
