MAIN = main
all: $(MAIN).pdf
$(MAIN).pdf: $(MAIN).tex
	pdflatex -interaction=nonstopmode $(MAIN).tex
	pdflatex -interaction=nonstopmode $(MAIN).tex
clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb
.PHONY: all clean
