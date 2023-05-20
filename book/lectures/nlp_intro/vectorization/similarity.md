# Word Similarity

## Two ways NLP uses context for semantics

`Distributional similarity`: (vector-space semantics)

- Assume that words that occur in similar contexts have similar meanings.
- Use the `set of all contexts` in which a word occurs to measure the `similarity` between words.

`Word sense disambiguation`:

- Assume that if a word has multiple meanings, then it will occur in different contexts for each meaning.
- Use the context of a particular occurrence of a word to identify the `sense` of the word in that context.

## Distributional Similarity

### Basic idea

- Measure the semantic `similarities of words` by measuring the `similarity of their contexts` in which they occur

### How?

- Represent words as `sparse vectors` such that:
  - each `vector element` (dimension) represents a different `context`
  - the `value` of each element is the `frequency` of the context in which the word occurs, capturing how `strongly` the word is associated with that context
- Compute the `semantic similarity of words` by measuring the `similarity of their context vectors`

### The Information Retrieval perspective: The Term-Document Matrix

In information retrieval, we search a collection of $N$ documents for $M$ terms:

- We can represent each `word` in the vocabulary $V$ as an $N$-dimensional vector $v_w$ where $v_{w,i}$ is the `frequency` of the word $w$ in document $i$.
- Conversely, we can represent each `document` as an $M$-dimensional vector $v_d$ where $v_{d,j}$ is the `frequency` of the term $t_j$ in document $d$.

Finding the `most relevant` documents for a query $q$ is equivalent to finding the `most similar` documents to the query vector $v_q$.

- Queries are also documents, so we can use the same vector representation for queries and documents.
- Use the similarity of the query vector $v_q$ to the document vectors $v_d$ to rank the documents.
- Documents are similar to queries if they have similar terms.

## Term-Document Matrix

![](figs/2.png)

A term-document matrix is a 2D matrix:

- each row represents a `term` in the vocabulary
- each column represents a `document`
- each element is the `frequency` of the term in the document

![](figs/3.png)

- Each `column vector` = a `document`
  - Each entry = the `frequency` of the term in the document
- Each `row vector` = a `term`
  - Each entry = the `frequency` of the term in the document

> Two documents are similar if their vectors are similar.

> Two words are similar if their vectors are similar.

For information retrieval, the term-document matrix is useful because it allows us to represent documents as vectors and compute the similarity between documents in terms of the words they contain, or of terms in terms of the documents they occur in.

We can adapt this idea to implement `a model of the distributional hypothesis` if we treat each context as a column in the matrix and each word as a row.

### What is a `context`?

There are many ways to define a context:

**Contexts defined by nearby words:**

- How often does the word $w_i$ occur within a window of $k$ words of the word $w_j$?
- Or, how often do the words $w_i$ and $w_j$ occur in the same document or sentence?
- This yields fairly broad thematic similarities between words.

**Contexts defined by `grammtical relations`:**

- How often does the word $w_i$ occur as the `subject` of the word $w_j$?
- This requires a `grammatical parser` to identify the grammatical relations between words.
- This yields more `fine-grained` similarities between words.

### Using nearby words as contexts

1. Define a fixed vocabulary of $N$ context words $c_1 , \ldots , c_N$

- Contexts words should occur frequently enough in the corpus that you can get reliable counts.
- However, you should ignore very frequent words (stopwords) like `the` and `a` because they are not very informative.

2. Define what `nearby` means:

- For example, we can define a `window` of $k$ words on either side of the word $w_j$.

2. Count the number of times each context word $c_i$ occurs within a window of $k$ words of the word $w_j$.
3. Define how to transform the co-occurrence counts into a vector representation of the word $w_j$.

- For example, we can use the (positive) `PMI` of the word $w_j$ and the context word $c_i$.

4. Compute the similarity between words by measuring the similarity of their context vectors.

- For example, we can use the cosine similarity of the context vectors.

### Word-Word Matrix

![](figs/4.png)

### Defining co-occurrences:

- `Within a fixed window`: $c_i$ occurs within $\pm n$ words of $w$
- `Within the same sentence`: requires sentence boundaries
- `By grammatical relations`: $c_i$ occurs as a subject/object/modifier/… of verb $w$ (requires parsing - and separate features for each relation)

### Representing co-occurrences:

- $f_i$ as` binary features` (1,0): $w$ does/does not occur with $c_i$
- $f_i$ as frequencies: $w$ occurs $n$ times with $c_i$
- $f_i$ as probabilities: e.g. $f_i$ is the probability that $c_i$ is the subject of $w$.

### Getting co-occurrence counts

Co-occurrence as a `binary` feature:

- Does word $w$ ever appear in the context $c$? (1 = yes/0 = no)

![](figs/6.png)

Co-occurrence as a frequency count:

- How often does word $w$ appear in the context $c$? (0,1,2,… times)

![](figs/7.png)

### Counts vs PMI

Sometimes, low co-occurrences counts are very informative, and high co-occurrence counts are not:

- Any word is going to have relatively high co-occurrence counts with very common contexts (e.g. `the` with `a`), but this won’t tell us much about what that word means.
- We need to identify when co-occurrence counts are higher than we would expect by chance.

We can use pointwise mutual information (PMI) values instead of raw frequency counts:

$$ PMI(w,c) = \log \frac{p(w,c)}{p(w)p(c)} $$

![](figs/8.png)

### Computing PMI of $w$ and $c$:

#### Using a fixed window of $\pm k$ words

- $N$: How many tokens does the corpus contain?
- $f(w) \le N$: How often does $w$ occur?
- $f(w, c) \le f(w)$: How often does $w$ occur with $c$ in its window?
- $f(c) = \sum_w f(w, c)$: How many tokens have $c$ in their window?

$$p(w) = \frac{f{w}}{N}, p(c) = \frac{f(c)}{N}, p(w,c) = \frac{f(w,c)}{N}$$

$$PMI(w,c) = \log \frac{p(w,c)}{p(w)p(c)}$$

Positive Pointwise Mutual Information

PMI is negative when words co-occur less than expected by chance.

- This is unreliable without huge corpora:
- With $P(w ) \approx P(w2 ) \approx 10^{−6}$ , we can’t estimate whether $P(w_1 , w_2 )$ is significantly different from $10^{−12}$

We often just use positive PMI values, and replace all negative PMI values with 0:

Positive Pointwise Mutual Information (PPMI):

$$
\text{PPMI}(w, c) = PMI, \text{ if } \text{PMI}(w, c) \gt 0
$$

$$
\text{PPMI}(w, c) = 0, \text{ if } \text{PMI}(w, c) \le 0
$$

PMI and smoothing

PMI is biased towards infrequent events:

- If $P(w, c) = P(w) = P(c)$, then $\text{PMI}(w, c) = \log (\frac{1}{P(w)})$
- So $\text{PMI}(w, c)$ is larger for rare words $w$ with low $P(w)$.

Simple remedy: `Add-k smoothing` of $P(w, c), P(w), P(c)$ pushes all PMI values towards zero.

- Add-k smoothing affects low-probability events more, and will therefore reduce the bias of PMI towards infrequent events. (Pantel & Turney 2010)

## Dot product as similarity

If the vectors consist of simple binary features (0,1), we can use the `dot product` as `similarity metric`:

$$
sim_{dot-prod}(\vec{x}\cdot\vec{y}) = \sum_{i=1}^{N} x_i \times y_i
$$

The dot product is a bad metric if the vector elements are arbitrary features: it prefers `long` vectors

- If one $x_i$ is very large (and $y_i$ nonzero), $sim(x, y)$ gets very large
- If the number of nonzero $x_i$ and $y_i$ is very large, $sim(x, y)$ gets very large.
- Both can happen with frequent words.

$$
\text{length of }\vec{x}: |\vec{x}|=\sqrt{\sum_{i=1}^{N}x_i^2}
$$

## Vector similarity: Cosine

One way to define the similarity of two vectors is to use the cosine of their angle.

The cosine of two vectors is their dot product, divided by the product of their lengths:

$$
sim_{cos}(\vec{x},\vec{y})=\frac{\sum_{i=1}^{N} x_i \times y_i}{\sqrt{\sum_{i=1}^{N}x_i^2}\sqrt{\sum_{i=1}^{N}y_i^2}} = \frac{\vec{x}\cdot\vec{y}}{|\vec{x}||\vec{y}|}
$$

> $sim(\mathbf{w}, \mathbf{u}) = 1$: $\mathbf{w}$ and $\mathbf{u}$ point in the same direction

> $sim(\mathbf{w}, \mathbf{u}) = 0$: $\mathbf{w}$ and $\mathbf{u}$ are orthogonal

> $sim(\mathbf{w}, \mathbf{u}) = -1$: $\mathbf{w}$ and $\mathbf{u}$ point in the opposite direction

### Visualizing cosines

![](figs/cosine-viz.png)
