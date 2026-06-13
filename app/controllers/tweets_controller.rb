class TweetsController < ApplicationController
  # 一覧表示
  def index
    if params[:tag_ids]
      @tweets = []
      params[:tag_ids].each do |key, value|
        if value == '1'
          tag_tweets = Tag.find_by(name: key)&.tweets
          if tag_tweets
            @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
          end
        end
      end
    elsif params[:tag].present?
      @tweets = Tag.find_by(name: params[:tag])&.tweets || []
    else
      @tweets = Tweet.all.order(created_at: :desc)
    end
  end

  # 新規投稿画面
  def new
    @tweet = Tweet.new
  end

  # 投稿保存
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id

    # ひとこと処理
    if params[:tweet][:body].present?
      if @tweet.progress.blank?
        @tweet.progress = "💬 ひとこと:\n#{params[:tweet][:body]}"
      else
        @tweet.progress = "#{@tweet.progress}\n\n💬 ひとこと:\n#{params[:tweet][:body]}"
      end
    end

    # タグの自動抽出処理
    tags = params[:tweet][:body].scan(/#\w+/)
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.delete('#'))
      @tweet.tags << tag unless @tweet.tags.include?(tag)
    end
    
    if @tweet.save
      redirect_to tweets_path
    else
      render :new
    end
  end

  # 編集画面
  def edit
    @tweet = Tweet.find(params[:id])
  end

  # 更新処理
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "更新しました"
    else
      render :edit
    end
  end

  # 削除
  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.destroy
    end
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:time, :progress, :question, :body, tag_ids: [])
  end

  def create
   @tweet = Tweet.new(tweet_params)
   @tweet.user_id = current_user.id

   # タグの保存処理
   if params[:tag_list].present?
     # カンマ区切りの文字列を分割し、前後の空白を削除
     tag_names = params[:tag_list].split(',').map(&:strip).reject(&:blank?)
    
     tag_names.each do |name|
      # 存在しなければ作成、あれば取得
       tag = Tag.find_or_create_by(name: name)
       @tweet.tags << tag unless @tweet.tags.include?(tag)
      end
    end

    if @tweet.save
     redirect_to tweets_path, notice: "投稿しました！"
    else
     render :new
    end
  end

end