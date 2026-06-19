class TweetsController < ApplicationController
  # 一覧表示
  def index
    if params[:tag].present?
      @tweets = Tag.find_by(name: params[:tag])&.tweets || []
    else
      @tweets = Tweet.all.order(created_at: :desc)
    end
  end

  # 新規投稿画面
  def new
    @tweet = Tweet.new
  end

 def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id

    # 1. ひとことの内容をprogressに結合
    if params[:tweet][:body].present?
      @tweet.progress = [@tweet.progress, "💬 ひとこと:\n#{params[:tweet][:body]}"].compact.join("\n\n")
    end

    # 2. タグの保存処理（ユーザーが自由に作成・選択）
    if params[:tag_list].present?
      params[:tag_list].split(',').map(&:strip).each do |name|
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

end