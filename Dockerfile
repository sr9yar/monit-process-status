FROM ruby:2.6

ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# debconf error 
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client  net-tools

# required by curb
RUN apt-get install -y libcurl3 libcurl3-gnutls libcurl4-openssl-dev


ADD project /project
WORKDIR /project
RUN bundle install
# RUN rake db:create

ADD entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

CMD ["/usr/bin/entrypoint.sh"]

# CMD ["tail", "-f", "/dev/null"]

