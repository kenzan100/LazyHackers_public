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
    hack_tags = HackTag.where(:id=>params[:hack_tag_ids])
    Progre.create_all_success(hack_tags, params[:user_id], params[:scope_id])

    @scope = Scope.find(params[:scope_id])
    
    done_count = @scope.progres.where('DATE(done_when)=? AND scope_id = ? AND success = ?', Date.today, @scope.id, true).group(:user_id).each.count
    users = Progre.where('scope_id=? AND success = ?', @scope.id, true).group(:user_id)
    users_count = users.each.count
    
    UsersHacktag.update_from_progres(Progre.where('scope_id=? AND success = ?', @scope.id, true))
    
    if users_count > 1 && done_count == users_count && Time.now.hour > 9
      users.each do |users_progre|
        @mail = NotificationMailer.sendmail_congrats(User.find(users_progre.user_id).email, @scope.hack_tags.where('root_flag IS NULL OR root_flag = ?', false), @scope, current_user).deliver
      end
      flash[:notice] = 'おめでとう！　本日分、全員が達成しました！　お祝いメールが送られます。'
    elsif users_count > 1 && done_count == users_count
      flash[:notice] = 'おめでとう！　本日分、全員が達成しました！　深夜なので、こっそりここで貴方にだけ伝えます。'
    else
      flash[:notice] = 'おつかれさまです！他の人を応援してみては？'
    end
    
    redirect_to @scope
  end
  
  # POST /progres
  # POST /progres.xml
  def create
    
    if params[:create_all] == 'true'
      hack_tags = HackTag.where(:id=>params[:hack_tag_ids])
      Progre.create_all_success_with_comment(hack_tags, params[:this_user_id], params[:this_scope_id], params[:this_comment])
    else
      @progre = Progre.new(params[:progre])
    end
    
    if params[:create_all] == 'true'
      @scope = Scope.find(params[:this_scope_id].to_i)
      redirect_to @scope, :notice=>'ありがとう！あなたのtipsは皆を救うことでしょう。'
    else
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
