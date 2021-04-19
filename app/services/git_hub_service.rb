class GitHubService
  # SRP: Communicate with Github API
    def initialize(token)
      @token = token
    end

    def conn
      Faraday.new(
        url: 'https://api.github.com',
        headers: {
          'Authorization' => "token #{@token}",
          'Accept' => 'application/vnd.github.v3+json'
        }
      ) # Set up a "connection" object
    end

    def get_commits
      resp = conn.get('/repos/georgehwho/little-esty-shop/commits')
      JSON.parse(resp.body, symbolize_names: true)
    end

    def get_collaborators
      resp = conn.get('/repos/georgehwho/little-esty-shop/collaborators')
      JSON.parse(resp.body, symbolize_names: true)
    end

    def get_followers
      resp = conn.get('/user/followers') # sends a request
      JSON.parse(resp.body, symbolize_names: true)
    end

    def get_followings
      resp = conn.get('/user/following') # sends a request
      JSON.parse(resp.body, symbolize_names: true)
    end

    def follow(username)
      resp = conn.put("/user/following/#{username}") do |req|
        req.headers['Content-Length'] = 0
      end
    end
  end