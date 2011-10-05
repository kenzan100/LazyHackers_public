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
    
    if params[:temp] == 'true'
      #あらためて、HackTagをセーブする　@scope.hack_tags.where(:name=>flash[:temp_name]).save
      
    end

    respond_to do |format|
      if @users_scope.save
        params[:hack_tag_ids].each do |hack_tag_id|
          unless UsersHacktag.exists?(:user_id=>current_user.id, :hack_tag_id=>hack_tag_id)
            users_hacktag = UsersHacktag.new(:user_id=>current_user.id, :hack_tag_id=>hack_tag_id)
            users_hacktag.save
          end
          progre = Progre.new(:user_id=>current_user.id, :success=>false, :done_when=>Time.now)
          progre.hack_tag_id = hack_tag_id
          progre.scope_id = params[:scope_id]
          progre.save
        end
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
        params[:hack_tag_ids].each do |hack_tag_id|
          unless UsersHacktag.exists?(:user_id=>current_user.id, :hack_tag_id=>hack_tag_id)
            users_hacktag = UsersHacktag.new(:user_id=>current_user.id, :hack_tag_id=>hack_tag_id)
            users_hacktag.save
          end
        end
        format.html { redirect_to(scopes_path, :notice => '今度はこの組み合わせで、頑張ってみてね。') }
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
      format.html { redirect_to(scopes_url, :notice=>'あなたの挑戦中リストから、そのセットが削除されました。「やったよ」記録は残っているので、また興味があったときに見てくださいね！') }
      format.xml  { head :ok }
    end
  end
end
