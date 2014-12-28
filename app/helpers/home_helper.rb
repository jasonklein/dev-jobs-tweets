module HomeHelper

  def haml_for_post(post)
    if post.is_a? Tweet
      render partial: "tweet", locals: {tweet: post}
    else
      render partial: "musing", locals: {musing: post}
    end
  end
  
end