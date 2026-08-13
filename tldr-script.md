# Five-minute script — *Mergeability Has a History*

Speaking notes for `tldr.pdf` (10 slides). Times are cumulative. Every number is reproduced by
`paper/make_beetle_mergeability_numbers.py`.

---

### 1 · Title — 0:00–0:15

Mergeability has a history. The claim is that whether you can merge two models is decided by how
they were trained — and much more narrowly than you would expect.

### 2 · The problem — 0:15–1:00

Two separately trained models usually cannot be averaged, and the literature gives two explanations
without separating them. Either the models organise the same computation under **different
coordinates** — networks have large symmetry groups, two runs land in different members of one
equivalence class — or they simply **learned different things**. The first is removable by a
function-preserving map. The second is not.

Nobody separates them because it is hard to. So we built the design that can: fix architecture,
parameter count, tokenizer, data budget, optimiser, evaluation — and vary *one factor of the
training history at a time*. Initialisation, data order, curriculum, first language. Then apply
alignment as an **intervention** and measure what it recovers. We apply the map rather than
correlate with it, which is what licenses a causal reading.

### 3 · The answer — 1:00–1:30

The answer came out sharper than our framing. Rescue does not track how different two histories
were. It tracks **whether the two models were initialised together** — on both outcome measures, on
all four merge operators, and on a model family we did not train.

Models sharing an initialisation are already in a common coordinate system. There is nothing to
remove, and fitting a map is at best free and at worst harmful.

### 4 · Result 1, the ladder — 1:30–2:15

Here is the ladder. Different initialisation costs 2.30 nats to compose; different data order costs
0.55. So initialisation costs about four times what data order costs.

But the important thing is that they are costs of **different kinds**. A fitted map removes 93% of
the initialisation gap — and makes the data-order gap 27% *worse*.

That negative rung is the one I would draw attention to. It is a case where alignment **must not**
help, and it does not. A method that helped everywhere would tell you nothing.

### 5 · Result 2, the merges — 2:15–2:50

Scaling up: 2,320 merges over 280 pairs. Cut on initialisation rather than on our own experimental
labels, alignment recovers **+0.244 nats** on independently initialised pairs and **−0.000** on
pairs that share an initialisation. Two separate experiments with different curricula give +0.244
and +0.238, intervals almost entirely overlapping.

One detail worth thirty seconds: the diagnostic **corrected our own metadata**. Our curriculum
condition was meant to hold initialisation fixed. It did not — two pairs were independently
initialised — and the weight-space decomposition detected that with no access to training logs. The
functional outcome then followed the diagnostic rather than the label.

### 6 · Result 3, the controls — 2:50–3:30

Three ways this could be something more boring, and all three are closed.

*It just moves B closer to A.* Interpolating by the same distance the map removes buys +0.036; the
map buys +1.405. **Thirty-nine times** more.

*Shared-init pairs are simply closer.* So we built a pair placed equally far apart with its
removable component exhausted by construction. It recovers **exactly zero** — in all eighteen cells.

*You picked the map that worked.* We walked the symmetry hierarchy. The best is the orthogonal
class. The worst is GL(d) — the richest map, which contains every other class and fits its own
objective best, and is **worse than doing nothing**, because it does not commute with RMSNorm and
so is not a symmetry at all.

Alignment works through symmetry, not distance reduction. Symmetry beats flexibility.

### 7 · Result 4, drift — 3:30–4:10

The strongest objection is that this is true by construction: if two runs start from identical
weights and nobody applies a permutation, units keep their identity by definition.

That objection has a testable alternative — representational drift, where units gradually change
role over a long run so the best correspondence stops being the identity. We measured it, walking
the checkpoint sequence from step 0.

Drift does not happen. At all. The identity-match fraction is 1.0000 at every checkpoint, and the
minimum over *every layer of every checkpoint* is also 1.0000 — not one unit out of 3072 × 14 ever
swaps. Independently initialised pairs sit at chance from step 0 onward.

So the claim is not definitional, because drift was a live alternative and is measured to be exactly
zero. And it means the obstruction is **fixed at step 0**: nothing in training creates it and
nothing removes it.

### 8 · Result 5, generality — 4:10–4:40

Three quick generalisations. On PolyPythia — another lab's models, different architecture,
tokenizer, corpus — the residual factor survives on **74 of 74** independently initialised pairs.
The detector never misses.

Across three language pairs the coordinate share is 92%, 89%, 93%, including a non-Indo-European
pair.

And beyond two models: as you merge more, naive merging collapses while the aligned merge barely
moves, so the rescue nearly triples from k=2 to k=5. **Alignment's value grows with merge size** —
the most practically useful sentence in the paper.

### 9 · Takeaways — 4:40–5:00

Alignment does not make models mergeable; it removes one obstruction, and that obstruction is
present when and essentially only when two models were initialised apart. Provenance is the index,
not similarity. Group membership is the currency, not distance and not flexibility. And the whole
thing is decidable in advance from the weights, at held-out AUROC 0.944.

The honest limit: these are sub-200M models pretrained from scratch, where merging is destructive in
absolute terms — alignment moves merges from very bad to less bad. The claim is about the
*composition of the barrier*, not about shipping merged models at this scale. And note that the
condition — shared initialisation — is exactly what holds in the fine-tuning regime where merging
already works, so the negative rung is a mechanism for the field's positive results rather than a
contradiction of them.

### 10 · Close

Whatever pretraining does to make two models incompatible, it is not making their difference
irreducible.

---

## If you are cut to three minutes

Keep slides 2, 4, 5, 7, 9 — problem, ladder, merges, drift, takeaways. Drop the controls and the
generality slides; if challenged on either, the one-liners are "thirty-nine times what a matched
distance reduction buys" and "seventy-four out of seventy-four on another lab's models".

## Questions to expect

- **"Isn't this true by construction?"** → slide 7. Drift was a live alternative, measured at
  exactly zero.
- **"Does it matter, if the merges are bad anyway?"** → conceded on slide 9. The claim is about the
  barrier's composition, and the condition is what holds where merging does work.
- **"Your diagnostic is just detecting shared initialisation."** → agreed, and we say so: it is a
  detector with false positives, not a quantity that adds to initialisation. Only 2.6% of the effect
  is mediated. What makes it useful is that it is computable when provenance is unknown.
- **"Why not CKA?"** → CKA is *anti*-predictive here (AUROC 0.319). The pairs alignment rescues are
  the ones already functionally similar and merely mis-coordinated.
