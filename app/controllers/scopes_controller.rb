# coding: utf-8

class ScopesController < ApplicationController
  
  around_filter :profile_it, :only => :index, :if => lambda{Rails.env.profile?}

    # profiling around-filter - just does the controller-action only
    def profile_it
      require 'ruby-prof'
      ::RubyProf.start
      yield
      result = ::RubyProf.stop
      printer = ::RubyProf::CallTreePrinter.new(result)
      path = Rails.root.join("tmp/process_time.tree")
      File.open(path, 'w') do |f|
        printer.print(f, :min_percent => 0, :print_file => true)
      end
    end
    
  def list
    @scopes = Scope.all
    
    respond_to do |format|
      format.html # list.html.erb
      format.xml  { render :xml => @scopes }
    end
  end
  
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
      if searching_hack_tag_condition.count == 0
        @scope_to = scopes_path
        break
      elsif scope.hack_tags == searching_hack_tag_condition
        @scope_to = scope
        break
      end
    end
    
    if flash[:from_your_set] == 'true'
      params[:from_your_set] = 'true'
      params[:scope_id] = flash[:current_set_id]
    elsif flash[:from_search] == 'true'
      flash.keep(:from_search)
    end
  
    if @scope_to
      flash[:from_your_set] = params[:from_your_set]
      flash[:current_set_id] = params[:scope_id]
      redirect_to @scope_to, :notice=>'この深さだと、こんな感じです。'
    else
      @creating_scope = Scope.create_one_more_depth_scope(searching_hack_tag_condition)
      flash[:from_your_set] = params[:from_your_set]
      flash[:current_set_id] = params[:scope_id]
      redirect_to @creating_scope, :notice=>'New! その組み合わせだと、こんな感じです。'
    end
  end
  
  # GET /scopes
  # GET /scopes.xml
  def index
    
    @scopes = []
    Scope.all.each do |scope|
      if scope.hack_tags.where('singled_by IS NULL').length == 1
        HackTag.where(:root_flag=>true).each do |root_ht|
          if scope.hack_tags.exists?(:id=>root_ht.id)
            @scopes.push(scope)
          end
        end
      end
    end
    
    if user_signed_in?
      @friends = []
      @feed = []
      
      @my_scopes = Hash.new
      current_user.scopes.each do |my_scope|
        users_followers = HackTag.check_intersection(my_scope.hack_tags)
        @friends.push(users_followers[1])
        
        if Time.now.hour < 5
    		  my_tf = my_scope.progres.where('Date(done_when)=? AND user_id=?', Date.yesterday, current_user.id).exists?(:success=>true) || my_scope.progres.where('Date(done_when)=? AND user_id=?', Date.today, current_user.id).exists?(:success=>true)
    		else
    		  my_tf = my_scope.progres.where('Date(done_when)=? AND user_id=?', Date.today, current_user.id).exists?(:success=>true)
    		end
      	@my_scopes.store(my_scope, my_tf)
      end
      
      unless @friends.blank?
        @friends.flatten!.uniq!
      end
      
      current_user.scopes.each do |my_scope|
        @friends.each do |friend|
          friend.progres.order('done_when DESC').limit(5).where(:hack_tag_id=>my_scope.hack_tags.last.id, :success=>true).group("DATE(done_when)").each do |u_progre|
            @feed.push(u_progre)
          end
        end
      end
      @feed.uniq!
      @feed = @feed.sort{|a, b| b.done_when<=>a.done_when}
      @feed_dates = @feed.group_by{|e| e.done_when.strftime("%Y %m %d")}
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scopes }
    end
  end

  # GET
  def from_search
    scope = Scope.find(params[:id])
    flash[:from_search] = 'true'
    redirect_to scope, :notice=>'ここにはこれだけの人がいます。追加を押して、より細かく設定しましょう。'
  end

  # GET /scopes/1
  # GET /scopes/1.xml
  def show
    if flash[:from_your_set] == 'true'
      flash.keep(:from_your_set)
      flash.keep(:current_set_id)
    elsif flash[:from_search] == 'true'
      flash.keep(:from_search)
    end
    
    @progre = Progre.new
    @scope = Scope.find(params[:id])
    @hack_tags = @scope.hack_tags
    if @hack_tags.count == 1
      @shack_tags = @hack_tags
    else
      @shack_tags = @hack_tags.where('root_flag IS NULL OR root_flag = ?', false)
    end
    
    @next_hack_tags = []
    HackTag.all.each do |ht|
      if ht.hack_tag_follows.exists?(:greater_hack_tag_id=>@hack_tags.last.id)
        @next_hack_tags.push(ht)
      end
    end
    
    if user_signed_in?
      create_select_option_for_creation = HackTag.where(:name=>'新規作成').first
      @next_hack_tags.push(create_select_option_for_creation)
    end
    
    users_followers = HackTag.check_intersection(@hack_tags)
    @users = users_followers[0]
    @users.uniq!
    
    @five_am_issue = Hash.new
    @progres = []
    
    @users.each do |user|
      found_deeper_position = 0
      @next_hack_tags.each do |next_hack_tag|
        if next_hack_tag.progres.exists?(:user_id=>user.id, :success=>true)
          found_deeper_position = 1
          user.progres.order('done_when DESC').limit(10).where(:hack_tag_id=>next_hack_tag.id, :success=>true).group("DATE(done_when)").each do |u_progre|
            @progres.push(u_progre)
          end
        end
      end
      if found_deeper_position == 0
        user.progres.order('done_when DESC').limit(10).where(:hack_tag_id=>@hack_tags.last.id, :success=>true).group("DATE(done_when)").each do |u_progre|
          @progres.push(u_progre)
        end
      end
      
		  #やった、まだ、の朝5時を境にした判定
      if Time.now.hour < 5
  		  tf = user.progres.where('Date(done_when)=? AND user_id=?', Date.yesterday, user.id).exists?(:success=>true) || user.progres.where('Date(done_when)=? AND user_id=?', Date.today, user.id).exists?(:success=>true)
      	@five_am_issue[user.id] = tf
      	
      	#自分の場合は、scope_idでtf判定
      	if user.id == current_user.id
				  @current_user_tf = Progre.where('DATE(done_when)=?', Date.yesterday).exists?(:user_id=>current_user.id, :success=>true, :scope_id=>@scope.id) || Progre.where('DATE(done_when)=?', Date.today).exists?(:user_id=>current_user.id, :success=>true, :scope_id=>@scope.id)
			  end
  		else
  			@five_am_issue.store(user.id, user.progres.where('Date(done_when)=? AND user_id=?', Date.today, user.id).exists?(:success=>true))
      	if user_signed_in? && user.id == current_user.id
				  @current_user_tf = Progre.where('DATE(done_when)=?', Date.today).exists?(:user_id=>current_user.id, :success=>true, :scope_id=>@scope.id)
    	  end
  		end
    end
    @progres = @progres.sort{|a, b| b.done_when<=>a.done_when}
    @progres_dates = @progres.group_by{|e| e.done_when.strftime("%Y %m %d")}
    
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
