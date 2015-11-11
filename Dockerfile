FROM ubuntu
MAINTAINER Manuel Bahamondez "manuel@bahamondez.com"
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y postgresql-9.3
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y libpq-dev
RUN apt-get install -y libxml2 libxslt1-dev libmagickwand-dev postgresql-client-9.3 imagemagick
RUN apt-get install -y wkhtmltopdf
RUN apt-get install -y wget
RUN apt-get install -y libreadline-dev

RUN adduser deploy --home /home/deploy --shell /bin/bash --disabled-password --gecos ""
USER deploy
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
USER root
RUN ~deploy/.rbenv/plugins/ruby-build/install.sh
USER deploy
RUN ~/.rbenv/bin/rbenv install 2.1.6
RUN ~/.rbenv/bin/rbenv global 2.1.6

RUN ~/.rbenv/shims/gem install bundler
