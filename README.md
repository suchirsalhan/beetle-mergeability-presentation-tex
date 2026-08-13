# beetle-mergeability-presentation-tex

Every figure and table from the `jrf_beetle` representational-analysis suite and the
**Mergeability Has a History** paper, one per slide, on the Cambridge Beamer template.

| deck | slides | for |
|---|---|---|
| **[tldr.pdf](tldr.pdf)** | 10 | a five-minute talk: headline results and takeaways only |
| **[main.pdf](main.pdf)** | 111 | every figure and table |

[`tldr-script.md`](tldr-script.md) is a timed speaking script for the short deck, with a
three-minute cut and the questions to expect.

## Build

```bash
make            # -> main.pdf and tldr.pdf
```

Overleaf: upload the repository and set `main.tex` as the compile target.

## The arc

The deck runs representational similarity first, then composability, because the second question
only makes sense once the first is answered.

| | section | slides |
|---|---|---|
| **I** | How similar are the layers? / across languages / across scale / aligning and reconstructing / causal patching / robustness / the geometry itself | 70 |
| **II** | Parameter distance is not functional distance / provenance determines the cost of composing / the diagnostic / 2,320 merges / ruling out the alternatives / fixed at step 0 / external replication | 9 |
| | All of it, in numbers --- the paper's tables | 11 |
| | Additional panels | 16 |

Section titles and slide headlines state the finding; the explanatory line sits underneath in
small type.

## Layout

```
main.tex                      the deck
figures/                      95 figures, copied from the research repo
beamer*cambridge.sty          the Cambridge theme, vendored
cambridgecolours.sty
uc-cmyk.pdf / uc-rev-cmyk.pdf University crest, as shipped with the template
```

Theme from [suchirsalhan/cambridge-beamer-tex](https://github.com/suchirsalhan/cambridge-beamer-tex).
