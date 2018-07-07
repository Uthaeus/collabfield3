require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  
  context '#create_new_post_partial_path' do 
    it "returns a signed_in partial's path" do 
      helper.stub(:user_signed_in?).and_return(true)
      expect(helper.create_new_post_partial_path).to (
        eq 'posts/branch/create_new_post/signed_in'
      )
    end

    it "returns a signed_in partial's path" do 
      helper.stub(:user_signed_in?).and_return(false)
      expect(helper.create_new_post_partial_path).to (
        eq 'posts/branch/create_new_post/not_signed_in'
      )
    end
  end

  context '#all_categories_button_partial_path' do 
    it "returns an all_selected partial's path" do 
      controller.params[:category] = ''
      expect(helper.all_categories_button_partial_path).to (
        eq 'posts/branch/categories/all_selected'
      )
    end

    it "returns an all_not_selected partial's path" do 
      controller.params[:category] = 'category'
      expect(helper.all_categories_button_partial_path).to (
        eq 'posts/branch/categories/all_not_selected'
      )
    end
  end

  context '#no_posts_partial_path' do 
    it "returns a no_posts prtial's path" do 
      assign(:posts, [])
      expect(helper.no_posts_partial_path).to (
        eq 'posts/branch/no_posts'
      )
    end

    it "returns an empty partial's path" do 
      assign(:posts, [1])
      expect(helper.no_posts_partial_path).to (
        eq 'shared/empty_partial'
      )
    end
  end

  context '#post_format_partial_path' do 
    it "returns a home_page partial's path" do 
      helper.stub(:current_page?).and_return(true)
      expect(helper.post_format_partial_path).to (
        eq 'posts/post/home_page'
      )
    end

    it "returns a branch_page partial's path" do 
      helper.stub(:current_page?).and_return(false)
      expect(helper.post_format_partial_path).to (
        eq 'posts/post/branch_page'
      )
    end
  end

  context '#update_pagination_partial_path' do 
    it "returns an update_pagination partial's path" do 
      posts = double('posts', :next_page => 2)
      assign(:posts, posts)
      expect(helper.update_pagination_partial_path).to (
        eq 'posts/posts_pagination_page/update_pagination'
      )
    end

    it "returns a remove_pagination partial's path" do 
      posts = double('posts', :next_page => nil)
      assign(:posts, posts)
      expect(helper.update_pagination_partial_path).to (
        eq 'posts/posts_pagination_page/remove_pagination'
      )
    end
  end
end
