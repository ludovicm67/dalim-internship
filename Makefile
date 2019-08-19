NAME := report
INPUTS := report/meta.yaml \
	report/1_introduction.md \
	report/2_organisation.md \
	report/3_travail.md \
	report/4_conclusion.md

.PHONY: report
report: $(NAME).pdf

%.pdf: %.tex
	xelatex $*
	yes | bibtex $*
	xelatex $*
	xelatex $*

$(NAME).tex: $(INPUTS)
	pandoc -s \
		--template=report/template.tex \
		--natbib -N -o $@ $(INPUTS)

.PHONY: clean
clean:
	$(RM) $(NAME).*
