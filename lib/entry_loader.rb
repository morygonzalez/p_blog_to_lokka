#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require "rubygems"
require "yaml"
require "dm-core"
require File.dirname(__FILE__) + "/../../lib/lokka/entry"
require File.dirname(__FILE__) + "/set_categories"

DataMapper::Model.raise_on_save_failure = true

class EntryInsertion
  def initialize
    insert_categories
  end

  def load_entries
    YAML.load_file("#{File.dirname(__FILE__)}/p_blog_log.yml")
  end

  def insert_categories
    set_category = SetCategory.new
    set_category.insert_categories
  end

  def get_categories
    Category.all
  end

  def set_entry_category_id(entry)
    entry["category"] = "雑談" if entry["category"] == ""
    get_categories.each do |cat|
      return cat.id if entry["category"] == cat.title
    end
  end

  def insert_entries
    entries = load_entries
    entries.each do |entry|
      begin
        @entry = Entry.create(
          :id => nil,
          :user_id => 1,
          :category_id => set_entry_category_id(entry),
          :slug => entry["id"],
          :title => entry["name"],
          :body => entry["comment"],
          :type => "Post",
          :created_at => entry["date"],
          :updated_at => entry["mod"]
          # :frozen_tag_list => entry["tag"]
        )
        @entry.tag_list = entry["tag"]
        @entry.save
      rescue DataMapper::SaveFailureError
        return entry["name"]
      end
    end
  end
end
