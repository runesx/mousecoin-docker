FROM ubuntu:14.04

ARG USER_ID
ARG GROUP_ID

ENV HOME /home/mic3

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN groupadd -g ${GROUP_ID} mic3 \
	&& useradd -u ${USER_ID} -g mic3 -s /bin/bash -m -d ${HOME} mic3

RUN set -ex \
	&& apt-get update \
	&& apt-get -y install software-properties-common \
	&& add-apt-repository -y ppa:bitcoin/bitcoin \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates \
	&& apt-get install -y libboost-all-dev libdb4.8-dev libdb4.8++-dev libminiupnpc-dev \
	&& rm -rf /var/lib/apt/lists/*

# install mic3 binaries
COPY /bin/mic3d /usr/local/bin/

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]