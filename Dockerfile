FROM ruby:2.4.4-alpine3.7

LABEL alpine-docs https://wiki.alpinelinux.org/wiki/How_to_get_regular_stuff_working

ENV JEKYLL_ENV production

WORKDIR /usr/app

ADD ./Gemfile /usr/app/Gemfile

RUN \
    apk update && \
    apk add build-base gcc abuild binutils binutils-doc \
    gcc-doc cmake nodejs nodejs-npm cmake-doc yarn && \
    gem update --system && \
    echo "gem: --no-rdoc --no-ri" >> ~/.gemrc && \
    gem install bundler --no-rdoc --no-ri && \
    cd /usr/app && \
    bundle install && \
    rm -rf /usr/lib/ruby/gems/*/cache/*.gem

ADD ./ /usr/app

EXPOSE 4000

CMD jekyll serve -d /_site --force_polling -H 0.0.0.0 -P 4000
