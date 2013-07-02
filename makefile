PDFLATEXERR=pdflatex -interaction=errorstopmode -shell-escape
PDFLATEX=pdflatex -interaction=batchmode -shell-escape

ODIR=output
EXEC=pgc

SERIE=Serie_00


all: $(EXEC)

pgc:
	if [ ! -d $(ODIR) ]; then \
	mkdir $(ODIR); \
	fi
	$(PDFLATEXERR) -output-directory=$(ODIR) $(SERIE)e.tex
	$(PDFLATEXERR) -output-directory=$(ODIR) $(SERIE)c.tex

clean:
	rm -rf $(ODIR)/*.aux
	rm -rf $(ODIR)/*.bbl

mrproper: clean
	rm -rf $(ODIR)/*

