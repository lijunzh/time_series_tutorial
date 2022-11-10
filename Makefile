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
all: slides
slides: $(SLIDESNAME).pdf

# rules
%.pdf: %.tex $(DOCNAME).bib
	#$(LATEXMK) $(LATEXOPT) $(DEPOPT) $*.d $*
	$(LATEXMK) $(LATEXOPT) $*
	
$(DOCNAME).bib:
	$(BIBTOOL) --preserve.key.case=on --print.deleted.entries=off -q -s -d $(BIBFILES) -o $(DOCNAME).bib
	
# cleaning up
clean: mostlyclean bibclean
	$(LATEXMK) -silent -C

mostlyclean:
	$(LATEXMK) -silent -c
	$(RM) *.run.xml *.synctex.gz *.nav *.snm
	#$(RM) *.d

bibclean:
	$(RM) *.bbl *.bib *.blg

.PHONY: all doc clean bibclean mostlyclean force

# include auto-generated dependencies
#-include *.d
