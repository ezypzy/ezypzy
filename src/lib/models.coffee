# Load dependecies ------
resourceful = require("resourceful")
# -----

# Defining schema for CouchDB ==============================================================

# Item --------
exports.Item = resourceful.define "items", ->

  # Defining database engine -------
  @use "couchdb"
  # -------

  # Defining data types ------
  @property "image", String
  @property "description", String
  @property "quantity", Number
  @property "price", Number
  @property "comments", Array
  @property "created", Date
  @property "modified", Date
  @property "tags", Array
  @property "likes", Array
  @property "userId", Number
  # ------

  return undefined
# ------

# User -----
exports.User = resourceful.define "users", ->

  # Defining database engine -----
  @use "couchdb"
  # ------

  # Defining datatypes -----
  @property "name", String
  @property "username", String
  @property "password", String
  @property "email", String
  # -----

  return undefined

# ------


# ==========================================================================================
