class TwitterAccountsController < ApplicationController
  
  def new
    twitter_account = TwitterAccount.create(:user => current_user)
    redirect_to(twitter_account.authorize_url(twitter_callback_url))
  end
  
  def callback
    if params[:denied] && !params[:denied].empty?
      redirect_to(deals_url, :alert => 'Unable to connect with twitter: #{parms[:denied]}')
    else
      twitter_account = TwitterAccount.find_by_oauth_token(params[:oauth_token])
      twitter_account.validate_oauth_token(params[:oauth_verifier], twitter_callback_url)
      twitter_account.save
      if twitter_account.active?
        redirect_to("#{root_url}admin/user/#{current_user.id}", :notice => 'Twitter account activated! You will need to resend the last tweet.')
      else
        redirect_to("#{root_url}admin/user/#{current_user.id}", :notice => "Unable to activate twitter account.")
      end
    end
  end
  
  def send_tweet
    account = TwitterAccount.find_by_user_id(current_user.id)
    if account.blank?
      twitter_account = TwitterAccount.create(:user => current_user)
      redirect_to(twitter_account.authorize_url(twitter_callback_url))
    else
      TwitterAccount.twitter_post("#{params[:animal_name]} is ready for adoption at #{root_url}animals/#{params[:animal_uuid]}", current_user.id)
      redirect_to("#{root_url}admin/animals/#{params[:animal_id]}", :notice => 'Tweet Sent')
    end
  end
 
end