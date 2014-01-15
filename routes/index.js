
/*
 * GET home page.
 */

exports.index = function(req, res){
  // console.log(req.query.id)
  res.sendfile('public/index.html');
};


exports.servicetest = function(req, res){
  res.sendfile('plserver/servicetest/servicetest.html');
};
