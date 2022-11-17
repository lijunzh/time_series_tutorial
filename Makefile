LATEXMK = latexmk
RM = rm -f
BIBTOOL = bibtool

# options
LATEXOPT = -pdf		# pdflatex
DEPOPT = -M -MP -MF		# auto generate dependencies files
CONTINUOUS = -pvc		# real-time preview

# project-specific settings
DOCNAME = time_series
SLIDESNAME = slides
BIBFILES = $(shell find bib -type f -name *.bib)

# targets
all: $(SLIDESNAME).pdf
release: all squeeze
edit: $(SLIDESNAME).tex
	$(LATEXMK) $(LATEXOPT) $(CONTINUOUS) $(DEPOPT) $(doc).d $(doc)

# rules
%.pdf: %.tex $(DOCNAME).bib
	$(LATEXMK) $(LATEXOPT) $(DEPOPT) $*.d $*
	
$(DOCNAME).bib:
	$(BIBTOOL) --preserve.key.case=on --print.deleted.entries=off -q -s -d $(BIBFILES) -o $(DOCNAME).bib
	
# cleaning up
clean: squeeze bibclean
	$(LATEXMK) -silent -C
	$(RM) *.run.xml *.synctex.gz *.nav *.snm
	$(RM) *.d

squeeze:
	$(LATEXMK) -silent -c

bibclean:
	$(RM) *.bbl *.bib *.blg

.PHONY: all clean squeeze bibclean edit

# include auto-generated dependencies
-include *.d
