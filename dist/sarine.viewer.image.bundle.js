
/*!
sarine.viewer.image - v0.6.2 -  Tuesday, January 2nd, 2018, 4:40:58 PM 
 The source code, name, and look and feel of the software are Copyright © 2015 Sarine Technologies Ltd. All Rights Reserved. You may not duplicate, copy, reuse, sell or otherwise exploit any portion of the code, content or visual design elements without express written permission from Sarine Technologies Ltd. The terms and conditions of the sarine.com website (http://sarine.com/terms-and-conditions/) apply to the access and use of this software.
 */

(function() {
  var SarineImage, Viewer,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Viewer = (function() {
    var error, rm;

    rm = ResourceManager.getInstance();

    function Viewer(options) {
      console.log("");
      this.first_init_defer = $.Deferred();
      this.full_init_defer = $.Deferred();
      this.src = options.src, this.element = options.element, this.autoPlay = options.autoPlay, this.callbackPic = options.callbackPic;
      this.id = this.element[0].id;
      this.element = this.convertElement();
      Object.getOwnPropertyNames(Viewer.prototype).forEach(function(k) {
        if (this[k].name === "Error") {
          return console.error(this.id, k, "Must be implement", this);
        }
      }, this);
      this.element.data("class", this);
      this.element.on("play", function(e) {
        return $(e.target).data("class").play.apply($(e.target).data("class"), [true]);
      });
      this.element.on("stop", function(e) {
        return $(e.target).data("class").stop.apply($(e.target).data("class"), [true]);
      });
      this.element.on("cancel", function(e) {
        return $(e.target).data("class").cancel().apply($(e.target).data("class"), [true]);
      });
    }

    error = function() {
      return console.error(this.id, "must be implement");
    };

    Viewer.prototype.first_init = Error;

    Viewer.prototype.full_init = Error;

    Viewer.prototype.play = Error;

    Viewer.prototype.stop = Error;

    Viewer.prototype.convertElement = Error;

    Viewer.prototype.cancel = function() {
      return rm.cancel(this);
    };

    Viewer.prototype.loadImage = function(src) {
      return rm.loadImage.apply(this, [src]);
    };

    Viewer.prototype.setTimeout = function(delay, callback) {
      return rm.setTimeout.apply(this, [this.delay, callback]);
    };

    return Viewer;

  })();

  this.Viewer = Viewer;

  SarineImage = (function(_super) {
    __extends(SarineImage, _super);

    function SarineImage(options) {
      SarineImage.__super__.constructor.call(this, options);
      this.imagesArr = options.imagesArr, this.borderRadius = options.borderRadius;
    }

    SarineImage.prototype.convertElement = function() {
      return this.element;
    };

    SarineImage.prototype.first_init = function() {
      var defer, index, name, _i, _len, _ref, _t;
      defer = $.Deferred();
      if (!this.src) {
        this.failed();
        defer.resolve(this);
      } else {
        defer.notify(this.id + " : start load first image1");
        _t = this;
        _ref = this.imagesArr;
        for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
          name = _ref[index];
          this.fullSrc = this.src.indexOf('##FILE_NAME##') !== -1 ? this.src.replace('##FILE_NAME##', name) : this.src + name;
          this.loadImage(this.fullSrc).then(function(img) {
            var canvas, className, ctx, imgName;
            canvas = $("<canvas>");
            ctx = canvas[0].getContext('2d');
            if (img.src.indexOf('data:image') !== -1) {
              imgName = 'no_stone';
            } else {
              if (img.src.indexOf('?') !== -1) {
                className = img.src.substr(0, img.src.indexOf('?'));
                imgName = className.substr(className.lastIndexOf("/") + 1, className.lastIndexOf("/")).slice(0, -4);
              } else {
                imgName = img.src.substr(img.src.lastIndexOf("/") + 1, img.src.lastIndexOf("/")).slice(0, -4);
              }
            }
            canvas.attr({
              width: img.width,
              height: img.height,
              "class": imgName
            });
            if (_t.borderRadius) {
              canvas.css({
                'border-radius': _t.borderRadius
              });
            }
            ctx.drawImage(img, 0, 0, img.width, img.height);
            _t.element.append(canvas);
            return defer.resolve(_t);
          });
        }
      }
      return defer;
    };

    SarineImage.prototype.failed = function() {
      var _t;
      _t = this;
      return _t.loadImage(_t.callbackPic).then(function(img) {
        var canvas;
        canvas = $("<canvas >");
        canvas.attr({
          "class": "no_stone",
          "width": img.width,
          "height": img.height
        });
        canvas[0].getContext("2d").drawImage(img, 0, 0, img.width, img.height);
        return _t.element.append(canvas);
      });
    };

    SarineImage.prototype.full_init = function() {
      var defer;
      defer = $.Deferred();
      defer.resolve(this);
      return defer;
    };

    SarineImage.prototype.play = function() {};

    SarineImage.prototype.stop = function() {};

    return SarineImage;

  })(Viewer);

  this.SarineImage = SarineImage;

}).call(this);
