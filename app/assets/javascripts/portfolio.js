
var Portfolio = function (total, url) {
  var self = Object.create(Portfolio.prototype);

  var current_page = 0;
  var total_pages = total;
  var image_urls = url

  self.currentPage = function () {
    return image_urls[current_page];
  };

  self.nextPage = function () {
    if (current_page === total_pages-1) {
      current_page = 0;
    }
    else {
      current_page += 1;
    };
  };

  Object.freeze(self);
  return self;
};



$(window).load( function () {
  var $next = $('#next');

  var carousel = $('#carousel'),
  viewport = carousel.find('.viewport'),
  item = viewport.find('li'),
  itemWidth = item.outerWidth(true),
  itemNum = item.length,
  itemList = viewport.find('ul');

  $(item[0]).addClass('active');


  var slideTo = function (dir){
    var index;
    if ($('.active').is(':last-child')){
      index = item[0];
    } else {
      index = $('.active').next();
    }
    console.log(index);
    itemClicked( index );
  };


  var itemClicked = function (index) {
    $(index).siblings().removeClass( 'active' );
    $(index).addClass( 'active' );

    var position = $(index).position().left;
    newLeft = $(viewport).width() - position - $(index).width();
    console.log(newLeft);
    setCarouselLeft( newLeft );
  }


  var setCarouselLeft = function (newLeft ){
    $(next).unbind('click');

    $(itemList).animate( {left:newLeft+"px"},{
      duration: 500,
      complete: function(){
        $(next).bind('click', function(e){slideTo(1)});
      }
    });
  };

  $next.click( function () {
    slideTo(1);
  });

})


// ----------------------------------------
// Helper Functions
// ----------------------------------------

// http://stackoverflow.com/questions/15313418/javascript-assert
// assertion function for testing input values
var assert = function (condition, message) {
  if (!condition) {
    throw message || "Assertion failed";
  };
};

// Prof Jackson's from_to recursive loop
var fromTo = function (from, to, f) {
  if (from > to) return;
  f(from); fromTo(from+1, to, f);
};