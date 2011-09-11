#!/usr/bin/env ruby
#-*- coding: utf-8 -*-

require_relative "/lib/entry_loader"
require_relative "/lib/comment_loader"
# require File.dirname(__FILE__) + "/lib/entry_loader"
# require File.dirname(__FILE__) + "/lib/comment_loader"

es = EntryInsertion.new
es.insert_entries

cs = CommentInsertion.new
cs.insert_comments
