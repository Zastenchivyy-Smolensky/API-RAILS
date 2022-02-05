require 'rails_helper'

describe 'PostAPI' do
  it '全てのポストを取得する' do
    FactoryBot.create_list(:post, 10)

    get '/api/v1/posts'
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)

    expect(json['data'].length).to eq(10)
  end
  it "特定のpostを習得する" do
    post = FactoryBot.create(:post)
    post = create(:post, title:"test-title", content:"rails-test")
    get "/api/v1/posts/#{post.id}"
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json["data"]["title"]).to eq(post.title)
    expect(json["data"]["content"]).to eq(post.content)
  end
  it "新しいpostを作成する" do
    valid_params={title:"title"}
    valid_params1={content:"content"}
    expect { post '/api/v1/posts', params: { post: valid_params } }.to change(Post, :count).by(+1)
    expect { post "/api/v1/posts", params: { post: valid_params1}  }.to change(Post, :count).by(+1)
    expect(response.status).to eq(200)
  end
  it 'postの編集を行う' do
    post = create(:post, title: 'old-title')

    put "/api/v1/posts/#{post.id}", params: { post: {title: 'new-title'}  }

    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    #データが更新されている事を確認
    expect(json['data']['title']).to eq('new-title')
    
  end
  it "postを削除する" do
    post = create(:post)
    expect { delete "/api/v1/posts/#{post.id}"}.to change(Post, :count).by(-1)
    expect(response.status).to eq(200)
  end
end