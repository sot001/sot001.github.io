### Checking environment

    (as git)
    cd /opt/gitlab/embedded/service/gitlab-rails/
    HOME=/var/opt/gitlab
    PATH=/usr/local/bin:/usr/bin:/bin:/opt/gitlab/embedded/bin/
    bundle exec rake gitlab:check RAILS_ENV=production

### Prompted for git@git.server password

check selinux on the git.server.