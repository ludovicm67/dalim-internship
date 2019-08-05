# Useful variables:
SCRIPTS = $(wildcard scripts/*.sh)
REPORT_FILES = $(wildcard report/*)

# Build all targets (default)
.PHONY: all
all: pdf

# Building the pdf file
report.pdf: $(REPORT_FILES)
	@./scripts/report.sh

# Targets to call manually
.PHONY: report
report: report.pdf

.PHONY: pdf
pdf: report

.PHONY: clean
clean:
	rm -f ./*.pdf

# if needed…
.PHONY: exec
exec:
	chmod +x $(SCRIPTS)
