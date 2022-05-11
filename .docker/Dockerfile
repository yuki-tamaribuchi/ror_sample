FROM ruby:2.7.5

ARG USER_ID
ARG USER_NAME
ARG GROUP_ID
ARG GROUP_NAME
ENV USER_ID $USER_ID
ENV USER_NAME $USER_NAME
ENV GROUP_ID $GROUP_ID
ENV GROUP_NAME $GROUP_NAME

RUN apt update -y \
		&& apt install -y \
			zsh \
			curl \
			apt-transport-https \ 
			wget \ 
		&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
		&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
		&& apt update -y \
		&& apt install -y yarn


RUN getent group ${GROUP_NAME} || groupadd -g ${GROUP_ID} ${GROUP_NAME} \
	&& groupmod -g ${GROUP_ID} ${GROUP_NAME} \
	&& useradd -m -s /bin/bash -u ${USER_ID} -g ${GROUP_ID} -m ${USER_NAME}
	
RUN apt update -qq && apt install -y nodejs yarn
USER ${USER_NAME}