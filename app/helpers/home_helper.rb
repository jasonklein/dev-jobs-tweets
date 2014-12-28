module HomeHelper

  def haml_for_post(post)
    if post.is_a? Tweet
      if params[:action] == "index"
        render partial: "index_tweet", locals: {tweet: post}
      else
        render partial: "archive_tweet", locals: {tweet: post}
      end
    else
      if params[:action] == "index"
        render partial: "index_musing", locals: {musing: post}
      else
        render partial: "archive_musing", locals: {musing: post}     
      end   
    end
  end
  
end