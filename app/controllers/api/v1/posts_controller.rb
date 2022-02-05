module Api
    module V1
        class PostsController < ApplicationController
            before_action :set_post, only:[:show, :update, :destroy]
            def index
                post = Post.order(id: :desc)
                render json: {status: "SUCCESS", message: "Loaded posts", data:post}
            end
            def show
                render json: {status: "success",message:"Loaded posts", data:@post}
            end
            def create
                post = Post.new(post_params)
                if post.save
                    render json: {status: "SUCCESS", data:post}
                else
                    render json: {status: "ERROR", data:post.errors}
                end
            end

            def destroy
                @post.destroy
                render json: {status: "success", message: "Deleted the post", data: @post}
            end
            
            def update
                if @post.update(post_params)
                    render json:{status: "SUCCESS", message: "updated",data:@post}
                else
                    render json:{status: "success", message: "not updaaed", data:@post.errors}
                end
            end

            private
            
            def set_post
                @post = Post.find(params[:id])
            end

            def post_params
                params.require(:post).permit(:title)
            end
        end
    end
    
end


