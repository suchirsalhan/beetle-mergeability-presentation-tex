all: main.pdf tldr.pdf
main.pdf: main.tex
	pdflatex -interaction=nonstopmode main.tex
	pdflatex -interaction=nonstopmode main.tex
tldr.pdf: tldr.tex
	pdflatex -interaction=nonstopmode tldr.tex
	pdflatex -interaction=nonstopmode tldr.tex
clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb
.PHONY: all clean
