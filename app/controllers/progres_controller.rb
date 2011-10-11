# coding: utf-8

class ProgresController < ApplicationController
  
  # POST
  def post_notifications
    Progre.create_notification(User.all, params[:comment], params[:inst_flag].to_i)
    redirect_to notifications_progres_path, :notice=>'投稿されました:)'
  end
  
  # GET
  def notifications
    noti_hack_tags = HackTag.find(52)
    @notifications = noti_hack_tags.progres
  end
  
  # GET /progres
  # GET /progres.xml
  def index
    @progres = Progre.paginate(:page => params[:page])

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
    hack_tags = HackTag.where(:id=>params[:hack_tag_ids])
    success_progres = Progre.create_all_success(hack_tags, params[:user_id], params[:scope_id])

    @scope = Scope.find(params[:scope_id])
    if hack_tags.count == 1
      shack_tags = hack_tags
    else
      shack_tags = @scope.hack_tags.where('root_flag IS NULL OR root_flag = ?', false)
    end
    
    done_count = Progre.where('done_when>=? AND hack_tag_id=? AND success = ?', Time.now.beginning_of_day+5.hours, hack_tags.last.id, true).group(:user_id).each.count
    users_count = params[:user_ids].length
    
    UsersHacktag.update_from_progres(Progre.where('user_id=? AND scope_id=? AND success = ?', current_user.id, @scope.id, true))
    
    if users_count > 1 && done_count == users_count && Time.now.hour > 9
      params[:user_ids].each do |user_id|
        @mail = NotificationMailer.sendmail_congrats(User.find(user_id).email, shack_tags, @scope, current_user).deliver
      end
      success_progres.each do |success_progre|
        success_progre.update_attributes(:comment=>'今日は、全員達成したよ!')
      end
      flash[:notice] = 'おめでとう！　本日分、全員が達成しました！　お祝いメールが送られます。'
    elsif users_count > 1 && done_count == users_count
      success_progres.each do |success_progre|
        success_progre.update_attributes(:comment=>'今日は、全員達成したよ!')
      end
      flash[:notice] = 'おめでとう！　本日分、全員が達成しました！　深夜なので、こっそりここで貴方に伝えます。'
    else
      flash[:notice] = 'おつかれさまです！他の人を応援してみては？'
    end
    
    redirect_to @scope
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
  
  def add_comment
    hack_tags = HackTag.where(:id=>params[:hack_tag_ids])
    current_user = User.find(params[:current_user_id])
    
    hack_tags.each do |hack_tag|
      if current_user.progres.exists?(:hack_tag_id=>hack_tag.id, :success=>true)
        current_user.progres.where(:hack_tag_id=>hack_tag.id, :success=>true).last.update_attributes(:comment=>params[:comment])
      else
        your_latest_progre_for_hack_tag = Progre.new(:hack_tag_id=>hack_tag.id, :user_id=>current_user.id, :success=>true, :scope_id=>params[:scope_id], :done_when=>Time.now)
        your_latest_progre_for_hack_tag.comment = params[:comment]
        your_latest_progre_for_hack_tag.save
        #your_latest_progre_for_hack_tags.push(Progre.new(:hack_tag_id=>hack_tag.id, :user_id=>current_user.id, :success=>true, :scope_id=>params[:scope_id]))
      end
    end
    
    @scope = Scope.find(params[:scope_id].to_i)
    redirect_to @scope, :notice=>'ありがとう！あなたのtipsは皆を救うことでしょう。'
  end

  # PUT /progres/1
  # PUT /progres/1.xml
  def update
    @progre = Progre.find(params[:id])

    respond_to do |format|
      if @progre.update_attributes(params[:progre])
        format.html { redirect_to scopes_path, :notice => '更新成功!' }
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
