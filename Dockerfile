FROM golang:latest
RUN mkdir /kube-watch
WORKDIR /kube-watch
COPY . .
RUN curl https://glide.sh/get | sh
RUN glide install
RUN cd vendor && ls && cd ..
ENV GOPATH=/go:/kube-watch/vendor
RUN cd vendor && mv $(find . -maxdepth 1 | grep -v ./src | sed -n '1!p') ./src && cd ..
RUN cd vendor/src && ls
RUN "./scripts/BUILD.sh"
CMD ["./kube-watch"]