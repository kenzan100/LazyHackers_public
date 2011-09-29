# coding: utf-8

class ScopesController < ApplicationController
  
  # GET
  def search_scope_from_hack_tags
    from_current_scope = Scope.find(params[:scope_id])
    adding_removing_hack_tag = HackTag.where(:id => params[:hack_tag_id])
    if params[:add_flag] == 'true'
      searching_hack_tag_condition = from_current_scope.hack_tags + adding_removing_hack_tag
    else
      searching_hack_tag_condition = from_current_scope.hack_tags - adding_removing_hack_tag
    end
    
    Scope.all.each do |scope|
      if scope.hack_tags == searching_hack_tag_condition
        @scope_to = scope
        break
      end
    end
    
    if @scope_to
      redirect_to @scope_to, :notice=>'その範囲で仲間が見つかりました！'
    else
      @creating_scope = Scope.new(:image_url=>'lazycat.png')
      @creating_scope.save
      searching_hack_tag_condition.each do |shack_tag|
        creating_hacks_scope = HacksScope.new(:scope_id=>@creating_scope.id, :hack_tag_id=>shack_tag.id)
        creating_hacks_scope.save
      end
      redirect_to @creating_scope, :notice=>'どうやら あなたがこの範囲の先駆者です。がんばって！'
    end
  end
  
  # GET /scopes
  # GET /scopes.xml
  def index
    @hack_tags = []
    Progre.all.each do |progre|
      @hack_tags.push(progre.hack_tag)
    end
    @hack_tags = @hack_tags.group_by{|e| e.id}
    
    many_scopes = Hash.new
    @hack_tags.each do |hack_tag|
      hackscopes = HacksScope.where(:hack_tag_id=>hack_tag[0])
      hackscopes.each do |hackscope|
        many_scopes.store(Scope.find(hackscope.scope_id), hack_tag[1].size)
      end
    end
    
    @msz = many_scopes.size
    @scopes = Hash.new
    many_scopes.each do |scope, size|
      if scope.hack_tags.length == 1
        @scopes.store(scope, size)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scopes }
    end
  end

  # GET /scopes/1
  # GET /scopes/1.xml
  def show
    @scope = Scope.find(params[:id])
    @hack_tags = @scope.hack_tags
    @users = []
    a_users = []
    b_users = []
    h_progre_lengths = Hash.new
    @hack_tags.each_with_index do |hack_tag, i|
      
      h_progre_lengths.store('hack_tag.progres.length', hack_tag)
      
      if (i+1)%2 == 1
        a_users = []
        hack_tag.users.each do |user|
          a_users.push(user)
        end
      else
        b_users = []
        hack_tag.users.each do |user|
          b_users.push(user)
        end
      end
      if i == 0
        @users = a_users
      else
        @users = a_users & b_users
      end
    end
    @users.uniq!
    
    @progres = h_progre_lengths.sort{|a, b| b[0]<=>a[0]}.first[1].progres

    @users_scope = UsersScope.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scope }
    end
  end

  # GET /scopes/new
  # GET /scopes/new.xml
  def new
    @scope = Scope.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scope }
    end
  end

  # GET /scopes/1/edit
  def edit
    @scope = Scope.find(params[:id])
  end

  # POST /scopes
  # POST /scopes.xml
  def create
    @scope = Scope.new(params[:scope])

    respond_to do |format|
      if @scope.save
        format.html { redirect_to(@scope, :notice => 'Scope was successfully created.') }
        format.xml  { render :xml => @scope, :status => :created, :location => @scope }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scopes/1
  # PUT /scopes/1.xml
  def update
    @scope = Scope.find(params[:id])

    respond_to do |format|
      if @scope.update_attributes(params[:scope])
        format.html { redirect_to(@scope, :notice => 'Scope was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scopes/1
  # DELETE /scopes/1.xml
  def destroy
    @scope = Scope.find(params[:id])
    @scope.destroy

    respond_to do |format|
      format.html { redirect_to(scopes_url) }
      format.xml  { head :ok }
    end
  end
end
