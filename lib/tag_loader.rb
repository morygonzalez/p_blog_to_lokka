#!/usr/bin/env ruby
#-*- encoding: UTF-8 -*-

require "yaml"
require "dm-core"
require "dm-tags"
require File.dirname(__FILE__) + "/../../lib/lokka/entry"

YAML::ENGINE.yamler= 'syck'

class Tags
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 255
end

DataMapper::Model.raise_on_save_failure = true

class TagLoader
  def initialize
    @yaml = "p_blog_log.yml"
  end

  def load_yaml
    YAML.load_file(File.dirname(__FILE__) + "/../#{@yaml}")
  end

  def list_tags
    tags = []
    load_yaml.each do |log|
      log["tag"].split(",").each do |t|
        tags << t.downcase.strip
      end
    end
    tags.uniq
  end

  def save_tags
    list_tags.each do |tag|
      begin
        @tag = Tag.create(
          :id => nil,
          :name => tag
        )
        @tag.save
      rescue DataMapper::SaveFailureError
        return tag["name"]
      end
    end
  end

  def set_tag_to_entries
    yaml = load_yaml
    yaml.each do |y|
      entry = Entry.first(:slug => y["id"].to_s)
      p y['tag']
      entry.tag_list = y['tag'].to_s
      entry.save
    end
  end
end
