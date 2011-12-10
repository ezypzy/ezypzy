var resourceful;

resourceful = require("resourceful");

exports.Item = resourceful.define("items", function() {
  this.use("couchdb");
  this.property("image", String);
  this.property("description", String);
  this.property("quantity", Number);
  this.property("price", Number);
  this.property("comments", Array);
  this.property("created", Date);
  this.property("modified", Date);
  this.property("tags", Array);
  this.property("likes", Array);
  this.property("userId", Number);
});

exports.User = resourceful.define("users", function() {
  this.use("couchdb");
  this.property("name", String);
  this.property("username", String);
  this.property("password", String);
  this.property("email", String);
});
