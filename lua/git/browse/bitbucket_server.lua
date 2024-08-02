local path = require "git.utils.path"

local GitServer = require "git.browse.git_server"

local Bitbucket = {}
function Bitbucket.new(git_url, git_path, git_dir, branch)
  local self = setmetatable(GitServer.new(git_url, git_path, git_dir, branch), { __index = Bitbucket })

  return self
end

function Bitbucket:open(visual_mode)
  GitServer._open(self, visual_mode)
end

function Bitbucket:_open_visual_mode(relative_path, start_line, end_line)
  GitServer._open_url(path.join {
    self.git_url,
    self.path,
    "src",
    self.branch,
    relative_path .. "#lines-" .. tostring(start_line) .. ":" .. tostring(end_line),
  })
end

function Bitbucket:open_pull_request()
  -- PRs cannot be query through git ls-remote command
end

function Bitbucket:create_pull_request(target_branch)
  return GitServer._open_url(path.join {
    self.git_url,
    self.path,
    "pull-requests/new?source=" .. self.branch .. "&t=1",
  })
end

return Bitbucket
