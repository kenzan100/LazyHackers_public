# coding: utf-8

class ScopesController < ApplicationController
  
  # POST
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
    
    if flash[:from_your_set] == 'true'
      params[:from_your_set] = 'true'
      params[:scope_id] = flash[:current_set_id]
    end
    
    if @scope_to
      flash[:from_your_set] = params[:from_your_set]
      flash[:current_set_id] = params[:scope_id]
      redirect_to @scope_to, :notice=>'その組み合わせだと、こんな感じです。'
    else
      @creating_scope = Scope.new(:image_url=>'lazycat.png')
      @creating_scope.save
      searching_hack_tag_condition.each do |shack_tag|
        creating_hacks_scope = HacksScope.new(:scope_id=>@creating_scope.id, :hack_tag_id=>shack_tag.id)
        creating_hacks_scope.save
      end
      flash[:from_your_set] = params[:from_your_set]
      flash[:current_set_id] = params[:scope_id]
      redirect_to @creating_scope, :notice=>'その組み合わせだと、こんな感じです。'
    end
  end
  
  # GET /scopes
  # GET /scopes.xml
  def index
    
    @scopes = Scope.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scopes }
    end
  end

  # GET /scopes/1
  # GET /scopes/1.xml
  def show
    if flash[:from_your_set] == 'true'
      flash.keep(:from_your_set)
      flash.keep(:current_set_id)
    else
      #flash.now[:notice] = 'ここには、これだけの人がいます。プラスボタンを押すと、範囲を狭めたり、広げたりできます。'
    end
    
    @scope = Scope.find(params[:id])
    
    @hack_tags = []
    @hack_tags_singled = []
    @scope.hack_tags.each do |hack_tag|
      if hack_tag.singled_by.blank?
        @hack_tags.push(hack_tag)
      else
        @hack_tags_singled.push(hack_tag)
      end
    end
    
    users_followers = HackTag.check_intersection(@hack_tags)
    
    @users = users_followers[0]
    @followers = users_followers[1]
    @users.uniq!
    @followers.uniq!
    
    @progres = []
    @users.each do |user|
      user.progres.group("DATE(done_when)").each do |u_progre|
        @progres.push(u_progre)
      end
    end
    @progres = @progres.sort{|a, b| b.done_when<=>a.done_when}
    @progres_dates = @progres.group_by{|e| e.done_when.strftime("%Y %m %d")}
    
    #次の行は、プログレスの幅をもっと広げた状態です。
    #@progres = h_progre_lengths.sort{|a, b| b[0]<=>a[0]}.first[1].progres

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
  
  def cheering
    user = User.find(params[:user_id])
    @scope = Scope.find(params[:scope_id])
    hack_tags = @scope.hack_tags
    
    @cheering_progre = Progre.new(:user_id=>user.id, :scope_id=>@scope.id, :done_when=>Time.now)
    @cheering_progre.cheered_by = current_user.id
    @cheering_progre.save
    
      #if user.when_to_dos.where(:hack_id=>hack.id, :from_user_id=>0).present?
        #if Time.now.strftime("%H") < user.when_to_dos.where(:hack_id=>hack.id, :from_user_id=>0).last.desired_time.strftime("%H")
          #when_to_do = WhenToDo.new(:kind=>'cheer', :user_id=>user.id, :hack_tag_id=>hack_tag.id, :from_user_id=>current_user.id)
          #when_to_do.desired_time = user.when_to_dos.where(:hack_id=>hack.id, :from_user_id=>0).last.desired_time
      
          #if when_to_do.save
            #redirect_to(@party, :notice=>'応援メッセージが予約されました。やってくれるのが楽しみですね！')
          #else
            #redirect_to(@party, :notice=>'エラーが発生しました。申し訳ありませんが、もう一度お試しください。')
          #end
        #else
          #@mail = NoticeMailer.sendmail_cheer(user.email, current_user, hack.title).deliver
          #redirect_to(@party, :notice=>'この方の希望時刻は既に過ぎていたので、今すぐ送りました！ナイスセーブですね。')
        #end
      #else
        @mail = NotificationMailer.sendmail_cheer(user.email, current_user, hack_tags).deliver
        redirect_to(@scope, :notice => 'ありがとう！応援メールが正しく送信できました！')
      #end
  end
  
end
