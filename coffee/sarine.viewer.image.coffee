###!
sarine.viewer.image - v0.4.0 -  Thursday, March 31st, 2016, 10:34:10 AM 
 The source code, name, and look and feel of the software are Copyright © 2015 Sarine Technologies Ltd. All Rights Reserved. You may not duplicate, copy, reuse, sell or otherwise exploit any portion of the code, content or visual design elements without express written permission from Sarine Technologies Ltd. The terms and conditions of the sarine.com website (http://sarine.com/terms-and-conditions/) apply to the access and use of this software.
###
class SarineImage extends Viewer
	
	constructor: (options) -> 			
		super(options)		
		{@imagesArr, @borderRadius} = options	   	 	

	convertElement : () ->				
		@element		

	first_init : ()->
		defer = $.Deferred() 
		defer.notify(@id + " : start load first image1") 	 					
		
		_t = @			
		for name, index in @imagesArr 
			@loadImage(@src  + name).then((img)->
				canvas = $("<canvas>")
				ctx = canvas[0].getContext('2d')
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

	full_init : ()-> 
		defer = $.Deferred()
		defer.resolve(@)		
		defer
	play : () -> return		
	stop : () -> return

@SarineImage = SarineImage
		
