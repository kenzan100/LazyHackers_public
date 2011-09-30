# coding: utf-8

class UsersScopesController < ApplicationController
  # GET /users_scopes
  # GET /users_scopes.xml
  def index
    @users_scopes = UsersScope.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users_scopes }
    end
  end

  # GET /users_scopes/1
  # GET /users_scopes/1.xml
  def show
    @users_scope = UsersScope.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @users_scope }
    end
  end

  # GET /users_scopes/new
  # GET /users_scopes/new.xml
  def new
    @users_scope = UsersScope.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users_scope }
    end
  end

  # GET /users_scopes/1/edit
  def edit
    @users_scope = UsersScope.find(params[:id])
  end

  # POST /users_scopes
  # POST /users_scopes.xml
  def create
    @users_scope = UsersScope.new(params[:users_scope])

    respond_to do |format|
      if @users_scope.save
        format.html { redirect_to(scopes_path, :notice => '参加表明完了！その日やったタイミングで、やったよボタンを押してくださいね。がんばってね！') }
        format.xml  { render :xml => @users_scope, :status => :created, :location => @users_scope }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @users_scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users_scopes/1
  # PUT /users_scopes/1.xml
  def update
    @users_scope = UsersScope.find(params[:id])

    respond_to do |format|
      if @users_scope.update_attributes(params[:users_scope])
        format.html { redirect_to(scopes_path, :notice => 'その組み合わせで、心機一転 頑張ろう！') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @users_scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users_scopes/1
  # DELETE /users_scopes/1.xml
  def destroy
    @users_scope = UsersScope.find(params[:id])
    @users_scope.destroy

    respond_to do |format|
      format.html { redirect_to(scopes_url, :notice=>'その組み合わせが削除されました。また興味があったときに見てくださいね！') }
      format.xml  { head :ok }
    end
  end
end
