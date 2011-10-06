# coding: utf-8

class HackTagsController < ApplicationController
  # GET /hack_tags
  # GET /hack_tags.xml
  def index
    @hack_tags = HackTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hack_tags }
    end
  end

  # GET /hack_tags/1
  # GET /hack_tags/1.xml
  def show
    @hack_tag = HackTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hack_tag }
    end
  end

  # GET /hack_tags/new
  # GET /hack_tags/new.xml
  def new
    @hack_tag = HackTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hack_tag }
    end
  end

  # GET /hack_tags/1/edit
  def edit
    @hack_tag = HackTag.find(params[:id])
  end

  # POST
  def create_hack_tag_and_hacks_scope
    this_hack_tags = Scope.find(params[:this_scope_id]).hack_tags
    
    new_hack_tag = HackTag.new(:name=>params[:name], :image_url=>params[:image_url])
    new_hack_tag.save
    hack_tag_follow = HackTagFollow.new(:greater_hack_tag_id=>this_hack_tags.last.id, :hack_tag_id=>new_hack_tag.id)
    hack_tag_follow.save
    
    #this_hack_tags.push(new_hack_tag)
    new_hack_tag_objects = HackTag.where(:id=>new_hack_tag.id)
    @creating_scope = Scope.create_one_more_depth_scope(this_hack_tags+new_hack_tag_objects)
    
		users_scope = UsersScope.new(:user_id=>current_user.id, :scope_id=>@creating_scope.id)
		users_scope.save
		
    users_hacktag = UsersHacktag.new(:user_id=>current_user.id, :hack_tag_id=>new_hack_tag.id)
    users_hacktag.save
    
    progre = Progre.new(:user_id=>current_user.id, :success=>false, :done_when=>Time.now)
    progre.hack_tag_id = new_hack_tag.id
    progre.scope_id = @creating_scope.id
    progre.save
    
    flash[:notice] = 'あなたのタグが登録されました！あまりにやってないと部屋は消えちゃうんで、がんばってね。' 
    redirect_to @creating_scope
  end

  # POST /hack_tags
  # POST /hack_tags.xml
  def create
    @hack_tag = HackTag.new(params[:hack_tag])

    respond_to do |format|
      if @hack_tag.save
        format.html { redirect_to(@hack_tag, :notice => 'Hack tag was successfully created.') }
        format.xml  { render :xml => @hack_tag, :status => :created, :location => @hack_tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hack_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hack_tags/1
  # PUT /hack_tags/1.xml
  def update
    @hack_tag = HackTag.find(params[:id])

    respond_to do |format|
      if @hack_tag.update_attributes(params[:hack_tag])
        format.html { redirect_to(@hack_tag, :notice => 'Hack tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hack_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hack_tags/1
  # DELETE /hack_tags/1.xml
  def destroy
    @hack_tag = HackTag.find(params[:id])
    @hack_tag.destroy

    respond_to do |format|
      format.html { redirect_to(hack_tags_url) }
      format.xml  { head :ok }
    end
  end
end
