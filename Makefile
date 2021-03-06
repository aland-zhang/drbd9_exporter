PKG    = github.com/benjojo/drbd9_exporter
PREFIX = /usr

all: build/drbd9_exporter

# NOTE: This repo uses Go modules, and uses a synthetic GOPATH at
# $(CURDIR)/.gopath that is only used for the build cache. $GOPATH/src/ is
# empty.
GO            = GOPATH=$(CURDIR)/.gopath GOBIN=$(CURDIR)/build go
GO_BUILDFLAGS =
GO_LDFLAGS    = -s -w

build/drbd9_exporter: *.go
	$(GO) install $(GO_BUILDFLAGS) -ldflags "$(GO_LDFLAGS)" .

install: build/drbd9_exporter
	install -D -m 0755 build/drbd9_exporter "$(DESTDIR)$(PREFIX)/bin/drbd9_exporter"

vendor:
	$(GO) mod tidy
	$(GO) mod vendor

.PHONY: install vendor