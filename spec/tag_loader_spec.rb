#-*- coding: utf-8 -*-

require File.dirname(__FILE__) + '/../../spec/spec_helper'
require File.dirname(__FILE__) + '/../lib/tag_loader'

describe TagLoader do
  subject { TagLoader.new }

  context "タグをYAMLから読み込む" do
    it "YAMLを読み込めていること" do
      subject.load_yaml.should be_true
    end

    it { subject.list_tags.should be_kind_of(Array) }
  end

  it "tagsテーブルに取得したtagをそれぞれ保存する" do
    pending
  end

  it "タグのある記事とタグを関連づける" do
    pending
  end
end
