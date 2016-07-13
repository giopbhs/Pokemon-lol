module ApplicationHelper
	def gravatar_for(user, options= {size:80})
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}.png?s=48&d=#{CGI.escape("https://c4.staticflickr.com/8/7773/28278249675_67d04fa4fe_m.jpg")}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "img-circle")
	end
end


