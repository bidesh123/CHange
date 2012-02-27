module ApplicationHelper
  def get_users

    User.all.map {|u| unless u.first_name.nil?
        [u.first_name,u.id]
      else
        [u.email,u.id]
      end
    }
  end


  def add_images_link
    link_to_function "Add Image", "AddImages(this)"
  end

  def add_video_images_link
    link_to_function "Add Video Image", "AddOtherImages(this)"
  end

  def add_video_link
    link_to_function "Add Video", "AddVideos(this)"
  end

  Array.class_eval do
  def paginate(options = {})
    raise ArgumentError, "parameter hash expected (got #{options.inspect})" unless Hash === options

    WillPaginate::Collection.create(
        options[:page] || 1,
        options[:per_page] || 30,
        options[:total_entries] || self.length
    ) { |pager|
      pager.replace self[pager.offset, pager.per_page].to_a
    }
  end
end


  def set_value(page)
    videos=[]
    CategoryVideo.all(:order => "category_id").each do |cat|
      videos << cat.video
    end
    l = videos.length/2.to_f
     if l > l.to_i
      l=l+1
    else
      l=l.to_i
    end
    return videos.paginate(:page => page,:per_page => 2,:total_entries => l)
  end

  def set_video_value(store,page)
    @videos = []

    @assets= Asset.all(:assetable_type => "video", :store_id => store.id)
    @assets.each do |asset|
      @videos << Video.get(asset.assetable_id)
    end

   videos= @videos.sort{|x,y| x.title.downcase <=> y.title.downcase}

    l = videos.length/2.to_f
     if l > l.to_i
      l=l+1
    else
      l=l.to_i
    end
    return videos.paginate(:page => page,:per_page => 2,:total_entries => l)
  end

  def set_video_date_wise(store,page)
    @videos = []

    @assets= Asset.all(:assetable_type => "video", :store_id => store.id)
    @assets.each do |asset|
      @videos << Video.get(asset.assetable_id)
    end
    videos = @videos.sort{|x,y| x.source_updated_at <=> y.source_updated_at}
    l = videos.length/2.to_f
     if l > l.to_i
      l=l+1
    else
      l=l.to_i
    end
    return videos.paginate(:page => page,:per_page => 2,:total_entries => l)
  end

  def set_video_length_wise(store,page)
    @videos = []
    @assets= Asset.all(:assetable_type => "video", :store_id => store.id)
    @assets.each do |asset|
      @videos << Video.get(asset.assetable_id)
    end
    videos = @videos.sort{|x,y| x.source_file_size <=> y.source_file_size}
     l = videos.length/2.to_f
     if l > l.to_i
      l=l+1
    else
      l=l.to_i
    end
    return videos.paginate(:page => page,:per_page => 2,:total_entries => l)
  end
  
  def all_videos
    Video.all.map{|v|
      unless Asset.first(:assetable_type => "video", :assetable_id =>v.id).nil?
        [v.title, "http://#{request.host_with_port}/stores/store_desc?store_id="+Asset.first(:assetable_type => "video", :assetable_id =>v.id).store_id.to_s]
      end }
  end

  def page_select(url,pages)
    val =[]
    l=pages/2.to_f
    if l > l.to_i
      l=l+1
    else
      l=l.to_i
    end
    (1..l).each do |i|
      val << [i,"http://#{url}/stores/store_desc?page="+i.to_s]
    end
    return val
  end


end

