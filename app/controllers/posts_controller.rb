class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
 uses_tiny_mce


  def tag_cloud 
	@tags = Post.tag_counts # returns all the tags used 
  end 



  def index
    #@posts = Post.all
     @posts = Post.publish_post
     @user = @current_user
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @categories= @post.categories
    @tags = Post.tag_counts

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @user = @current_user
   # if @user == @post.fk
	  
    #else
     #   redirect_to post_path  
    #end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  def change_to_draft
    @post = Post.find(params[:id])
    @post.save_draft!
     redirect_to :action=>'show' and return
  end

  def change_to_publish
    @post = Post.find(params[:id])
    @post.publish!
    redirect_to :action=>'show' and return
  end

 def draft
  @posts = Post.draft_post
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
 end
  end
end
