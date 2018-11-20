
class SarineImage extends Viewer
	
	constructor: (options) -> 			
		super(options)		
		{@imagesArr, @borderRadius} = options	   	 	

	convertElement : () ->				
		@element		

	first_init : ()->
		defer = $.Deferred() 

		if !@src 
			@failed()
			defer.resolve(@)
		else 
			defer.notify(@id + " : start load first image1") 	 					
			
			_t = @			
			for name, index in @imagesArr 
				@fullSrc = if @src.indexOf('##FILE_NAME##') != -1 then @src.replace '##FILE_NAME##' , name else @src + name 
				@loadImage(@fullSrc).then((img)->
					canvas = $("<canvas>")
					ctx = canvas[0].getContext('2d')
					if(img.src.indexOf('data:image') != -1)
						imgName = 'no_stone'
					else
						if(img.src.indexOf('?') != -1)
							className = img.src.substr(0, img.src.indexOf('?'))				
							imgName = className.substr((className.lastIndexOf("/") + 1), className.lastIndexOf("/")).slice(0,-4)	 			
						else
							imgName = img.src.substr((img.src.lastIndexOf("/") + 1), img.src.lastIndexOf("/")).slice(0,-4)

					canvas.attr({width : img.width, height : img.height, class : imgName})	
					if _t.borderRadius then canvas.css({'border-radius' : _t.borderRadius})						
					ctx.drawImage(img, 0, 0, img.width, img.height) 
					_t.element.append(canvas)
					defer.resolve(_t)												
				)
		defer
	failed : () ->
		_t = @ 
		_t.loadImage(_t.callbackPic).then (img)->
			canvas = $("<canvas >")
			canvas.attr({"class": "no_stone" ,"width": img.width, "height": img.height}) 
			canvas[0].getContext("2d").drawImage(img, 0, 0, img.width, img.height)
			_t.element.append(canvas)	
	full_init : ()-> 
		defer = $.Deferred()
		if(@element.find('.no_stone').length > 0)
			@element.trigger('noStone')
		defer.resolve(@)
		defer
	play : () -> return		
	stop : () -> return

@SarineImage = SarineImage
		
