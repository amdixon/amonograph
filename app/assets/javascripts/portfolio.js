
var Page = function (total) {
  var self = Object.create(Page.prototype);

  var current_page = 0;
  var total_pages = total;

  self.currentPage = function () {
    return current_page;
  };

  self.nextPage = function () {
    if (current_page === total_pages) {
      current_page = 0;
    }
    else {
      current_page += 1;
    };
  };
  return self;
};