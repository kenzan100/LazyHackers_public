# coding: utf-8

class ProgresController < ApplicationController
  # GET /progres
  # GET /progres.xml
  def index
    @progres = Progre.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @progres }
    end
  end

  # GET /progres/1
  # GET /progres/1.xml
  def show
    @progre = Progre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @progre }
    end
  end

  # GET /progres/new
  # GET /progres/new.xml
  def new
    @progre = Progre.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @progre }
    end
  end

  # GET /progres/1/edit
  def edit
    @progre = Progre.find(params[:id])
  end

  def create_all
    if params[:hack_tag_singled_ids]
      params[:hack_tag_singled_ids].each do |htsid|
        progre = Progre.new
        progre.hack_tag_id = htsid
        progre.success = true
        progre.done_when = Time.now
        progre.scope_id = params[:scope_id]
        if user_signed_in?
          progre.user_id = params[:user_id]
        end
        progre.save
      end
    end
    
    params[:hack_tag_ids].each do |hack_tag_id|
      progre = Progre.new
      progre.hack_tag_id = hack_tag_id
      progre.success = true
      progre.done_when = Time.now
      progre.scope_id = params[:scope_id]
      if user_signed_in?
        progre.user_id = params[:user_id]
      end
      progre.save
    end
    
    
    @scope = Scope.find(params[:scope_id])
    
    redirect_to @scope, :notice=>'おつかれさまです！他の人を応援してみては？'
  end
  
  # POST /progres
  # POST /progres.xml
  def create
    @progre = Progre.new(params[:progre])

    respond_to do |format|
      if @progre.save
        format.html { redirect_to(@progre, :notice => 'Progre was successfully created.') }
        format.xml  { render :xml => @progre, :status => :created, :location => @progre }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @progre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /progres/1
  # PUT /progres/1.xml
  def update
    @progre = Progre.find(params[:id])

    respond_to do |format|
      if @progre.update_attributes(params[:progre])
        format.html { redirect_to(@progre, :notice => 'Progre was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @progre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /progres/1
  # DELETE /progres/1.xml
  def destroy
    @progre = Progre.find(params[:id])
    @progre.destroy

    respond_to do |format|
      format.html { redirect_to(progres_url) }
      format.xml  { head :ok }
    end
  end
end
