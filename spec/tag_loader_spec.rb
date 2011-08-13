#-*- coding: utf-8 -*-

require File.dirname(__FILE__) + '/../../spec/spec_helper'
require File.dirname(__FILE__) + '/../lib/tag_loader'

describe TagLoader do
  subject { TagLoader.new }

  context "タグをYAMLから読み込む" do
    it "YAMLを読み込めていること" do
      subject.load_yaml.should be_true
    end

    it "タグの一覧をYAMLから読み込む" do
      subject.list_tags.should be_kind_of(Array)
    end

    it "空白がトリムされてる" do
      subject.list_tags[rand(subject.list_tags.size)].should_not match(/^\s.+/)
      subject.list_tags[rand(subject.list_tags.size)].should_not match(/.+\s$/)
    end
    
    it "アルファベットは小文字になってる" do
      @target = subject.list_tags[rand(subject.list_tags.size)]
      @target.should match(/[a-z]+/) if @target =~ /[a-zA-Z]+/
    end
  end

  it "tagsテーブルに取得したtagをそれぞれ保存する" do
    pending "やんごとなき理由"
    subject.save_tags.should be_true
  end

  it "タグのある記事とタグを関連づける" do
    pending
  end

  after(:all) do
    Tag.all.destroy
    Tag.repository.adapter.execute('update sqlite_sequence set seq=0 where name="tags";')
  end
end
