require 'spec_helper'

describe ApplicationHelper do
  describe 'render_close_icon' do
    subject { helper.render_close_icon }

    it { should have_selector('a.close') }
  end

  describe 'flash_class' do
    subject { helper.flash_class(flash_key) }
    context 'when flash key is :notice' do
      let(:flash_key) { :notice }
      it { should == 'alert-success' }
    end
    context 'when flash key is :error' do
      let(:flash_key) { :error }
      it { should == 'alert-error' }
    end
  end

  describe 'render_user_bar' do
    def render
      helper.render_user_bar
    end

    context 'when user has signed in' do
      before do
        helper.should_receive(:user_signed_in?).with().and_return(true)
      end
      it 'renders signed_in_user_bar' do
        helper.should_receive(:render).with('signed_in_user_bar').once
        render
      end
    end

    context 'when user has not yet signed in' do
      before do
        helper.should_receive(:user_signed_in?).with().and_return(false)
      end
      it 'renders signed_out_user_bar' do
        helper.should_receive(:render).with('signed_out_user_bar').once
        render
      end
    end
  end

  describe 'render_flashes' do
    context 'when it is called twice' do
      it 'only renders flashes once' do
        helper.should_receive(:render).with('common/flashes').once

        helper.render_flashes
        helper.render_flashes
      end
    end
  end

end
