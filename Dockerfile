FROM ubuntu:mantic

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN apt-get install -y curl
RUN apt-get install -y default-jre
RUN apt-get install -y rlwrap

RUN apt-get install -y sudo

RUN npm install -g yarn

RUN mkdir /publish-spa /graph /out

RUN useradd -g users -G sudo -m logseq
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chown logseq:users /publish-spa /graph /out
USER logseq

RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
RUN brew install clojure/tools/clojure
RUN brew install borkdude/brew/babashka

RUN git clone https://github.com/logseq/publish-spa /publish-spa

WORKDIR /publish-spa
RUN pwd && ls
RUN yarn install
RUN yarn global add /publish-spa
 
RUN git clone https://github.com/logseq/logseq /publish-spa/logseq

WORKDIR /publish-spa/logseq

#RUN /bin/bash -c "$(curl -O https://download.clojure.org/install/linux-install-1.11.1.1273.sh)"

RUN git checkout 0.9.8

RUN yarn install --frozen-lockfile && yarn gulp:build && \
  clojure -M:cljs release publishing
 
COPY publish.sh /publish.sh

VOLUME ["/graph", "/out"]
CMD ["/publish.sh"]
