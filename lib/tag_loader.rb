#!/usr/bin/env ruby
#-*- encoding: UTF-8 -*-

require "yaml"

YAML::ENGINE.yamler= 'syck'

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
        tags << t
      end
    end
    tags.uniq
  end
end