# beetle-mergeability-presentation-tex

Every figure and table from the **Mergeability Has a History** paper and the `jrf_beetle`
representational-analysis suite, one per slide, on the Cambridge Beamer template.

**[main.pdf](main.pdf) — 110 slides, compiled and committed.**

## Build

```bash
make            # -> main.pdf  (runs pdflatex twice for the TOC)
```

Overleaf: upload the repository and set `main.tex` as the compile target.

## Contents

| section | slides | source |
|---|---|---|
| 1. Main figures | 9 | `figures/beetle-mergeability/fig2*.pdf`, in the paper's narrative order |
| 2. Tables | 11 | extracted from `paper/beetle_mergeability_icml.tex` |
| 3. Representational analysis | 70 | `figures/jrf_beetle/`, grouped by experiment |
| 4. Additional panels | 15 | `figures/slides/` and top-level panels |

Every figure slide carries its source filename underneath, so any slide traces back to the file
that produced it.

## Layout

```
main.tex                      the deck
figures/                      95 figures, copied from the research repo
beamer*cambridge.sty          the Cambridge theme, vendored
cambridgecolours.sty
uc-cmyk.pdf / uc-rev-cmyk.pdf University crest, as shipped with the template
```

Theme from [suchirsalhan/cambridge-beamer-tex](https://github.com/suchirsalhan/cambridge-beamer-tex);
the deck was generated programmatically and is then safe to edit by hand.
