default: $(patsubst %.md,%.html,$(wildcard *.md))

%.html: %.md template.html
	sed -e 's/{{title}}/$</' -e '/{{content}}/{r $<' -e 'd}' template.html > $@
