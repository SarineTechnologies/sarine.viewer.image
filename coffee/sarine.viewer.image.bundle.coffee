###!
sarine.viewer.image - v0.2.0 -  Thursday, July 9th, 2015, 1:40:58 PM 
 The source code, name, and look and feel of the software are Copyright © 2015 Sarine Technologies Ltd. All Rights Reserved. You may not duplicate, copy, reuse, sell or otherwise exploit any portion of the code, content or visual design elements without express written permission from Sarine Technologies Ltd. The terms and conditions of the sarine.com website (http://sarine.com/terms-and-conditions/) apply to the access and use of this software.
###

class Viewer
  rm = ResourceManager.getInstance();
  constructor: (options) ->
    console.log("")
    @first_init_defer = $.Deferred()
    @full_init_defer = $.Deferred()
    {@src, @element,@autoPlay,@callbackPic} = options
    @id = @element[0].id;
    @element = @convertElement()
    Object.getOwnPropertyNames(Viewer.prototype).forEach((k)-> 
      if @[k].name == "Error" 
          console.error @id, k, "Must be implement" , @
    ,
      @)
    @element.data "class", @
    @element.on "play", (e)-> $(e.target).data("class").play.apply($(e.target).data("class"),[true])
    @element.on "stop", (e)-> $(e.target).data("class").stop.apply($(e.target).data("class"),[true])
    @element.on "cancel", (e)-> $(e.target).data("class").cancel().apply($(e.target).data("class"),[true])
  error = () ->
    console.error(@id,"must be implement" )
  first_init: Error
  full_init: Error
  play: Error
  stop: Error
  convertElement : Error
  cancel : ()-> rm.cancel(@)
  loadImage : (src)-> rm.loadImage.apply(@,[src])
  setTimeout : (delay,callback)-> rm.setTimeout.apply(@,[@delay,callback]) 
    
@Viewer = Viewer 

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
		


