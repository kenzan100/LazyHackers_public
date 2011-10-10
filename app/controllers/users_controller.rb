# coding: utf-8

class UsersController < ApplicationController

  def index
    if user_signed_in? && current_user.id == 1 || current_user.id == 4
      @users = User.all
    else
      redirect_to root_path, :notice=>'you are not authorized to view that. sorry.'
    end
  end
  
  def show
    user = User.find(params[:id])
    @user_id = user.id
    @screen_name = user.screen_name
    
    @his_scopes = user.scopes
    
    respond_to do |format|
      format.html
    end
  end

  def edit
    if user_signed_in? &&  current_user.id.to_s == params[:id] || current_user.id == 1 || current_user.id == 4
      @user = User.find(params[:id])
    else
      redirect_to scopes_path, :notice=>'You must be own user or admin to view this. sorry!'
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(scopes_path, :notice => 'ユーザ情報が正しく更新されました :)') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
