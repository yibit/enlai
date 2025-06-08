NAME = enlai
VERSION = $(shell cat ./VERSION |awk 'NR==1 { print $1; }')
GOMODULES = ./...
MYHOME = $(PWD)
GOFILES = $(shell cd $(NAME) && go list $(GOMODULES) |grep -v /vendor/)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
COMMIT = $(shell git rev-parse --short HEAD)
RELEASEDATE = $(shell date '+%Y%m%d%H%M%S')
STATUS = $(shell tools/git-status-check.sh status)
LDFLAGS = "-X main.Version=$(NAME)-$(VERSION)-$(BRANCH)-$(COMMIT)-$(RELEASEDATE)-$@-$(STATUS) -s -w "
BDFLAGS = -pgo=auto

default: usage

usage:
	@echo "Usage:                                              "
	@echo "                                                    "
	@echo "    make command                                    "
	@echo "                                                    "
	@echo "The commands are:                                   "
	@echo "                                                    "
	@echo "    pdf       generate pdf form of the book         "
	@echo "    html      generate gitbook form of the book     "
	@echo "    epub      generate epub form of the book        "
	@echo "    mobi      generate mobi form of the book        "
	@echo "    serve     serve html version of book locally    "
	@echo "    deps      install deps tools                    "
	@echo "    clean     clean up the project                  "
	@echo "                                                    "

deps:
	cd tools && sh install.sh

lark:
	cd lark && CGO_ENABLED=0 go build $(BDFLAGS) -ldflags=$(LDFLAGS) -v -o $(MYHOME)/bin/crawler

all: html pdf epub mobi

pdf:
	cd $(NAME) && Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"

html:
	cd $(NAME) && Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

epub:
	cd $(NAME) && Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book')"

mobi:
	cd $(NAME) && Rscript -e "bookdown::calibre('_book/$(NAME).epub', 'mobi')"

wasabi:
	bash tools/all.sh

audios:
	bash tools/audios.sh

tts:
	bash tools/tts.sh $(NAME)/writing/new.Rmd $(NAME)/writing/new

web:
	bin/lark serve

serve:
	@cd $(NAME) && Rscript -e "bookdown::serve_book(dir = '.', output_dir = '_book', preview = TRUE, in_session = TRUE, quiet = FALSE)"

open: $(NAME)/_book/index.html
	@open $^

openpdf: $(NAME)/_book/$(NAME).pdf
	@open $^

.PHONY: clean distclean mobi lark crawler audios

clean:
	cd $(NAME) && rm -rf $(NAME).Rmd $(NAME).tex _bookdown_files *.log
	find . -name \*~ -type f |xargs -I {} rm -f {}

distclean: clean
	rm -rf $(NAME)/_book
