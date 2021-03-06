require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames::Filters do
  describe "#banners" do
    context "when TRUE" do
      before do
        @testopt.banners = true
      end

      describe "should remove banner blocks" do
        subject { 'foobar' }
        it_should_fix 'foo[xvid]bar',   'foo[divx]bar'
        it_should_fix 'foo[ xvid ]bar', 'foo[_divx_]bar'
      end

      describe "should recognize advers with various bracket styles" do
        subject { 'foobar' }
        it_should_fix 'foo[xvid]bar', 'foo(xvid)bar'
        it_should_fix 'foo{xvid}bar', 'foo<xvid>bar'
      end
    end

    context "when FALSE" do
      before do
        @testopt.banners = false
        @testopt.charstrip_allow_brackets = true
      end

      describe "should ALLOW banner blocks" do
        it_should_not_change 'abc[XVID]xyz', 'foo[divx]bar'
        it_should_not_change 'foo[xvid]bar', 'foo(xvid)bar'
        it_should_not_change 'foo{xvid}bar', 'foo<xvid>bar'
      end
    end
  end
end
