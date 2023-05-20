# Word Representation

**Words as Atomic Symbols:** In natural language processing, each word (or surface form) is treated as a unique symbol. To manage various forms of the same word, generalization rules are applied:

- _Normalization:_ This process maps all variants of the same word to the canonical variant.

  - Example: "Cat", "cat", and "CAT" all normalize to "cat".

- _Lemmatization:_ Here, each word is mapped to its lemma or base form. Note that lemmatized text may not always be grammatical.

  - Example: "Wants" and "wanted" both lemmatize to "want".

- _Stemming:_ This involves removing varying endings from words to leave the root.
  - Example: "Running", "runner", and "ran" all stem to "run".

**Representing the Structure of Each Word:** This method involves breaking each word down into its core structure, often using a morphological analyzer.

- Example: The word "books" might be represented as "book N pl", denoting "book" as a noun in its plural form.

## Handling Unknown Words

**The UNK Token:** This approach replaces all rare words (those with a frequency below a certain threshold) in the training data with an UNK (Unknown word) token. The same token is used to represent any unknown words encountered post-training.

**Substring-based Representations:** In this method, words are represented as sequences of characters or substrings. An advanced version is Byte Pair Encoding (BPE), which treats common character sequences as atomic units.

- Example: The unknown word "Champaign" could be represented as a sequence of characters like ['C', 'h', 'a',…,'g', ’n'] or substrings like ["Ch", "amp", "ai", "gn"].

## Bag-of-words representation

Say we want to convert a corpus $D$ to a matrix $X$:

- In the `“bag-of-words”` representation, a row of $X$ is just the frequency distribution over words in the document corresponding to that row.

## Counts and frequencies

`Document counts`: number of documents where a token appears.

`Term counts`: number of total appearances of a token in corpus.

`Term frequency`:

$$ \text{Term Frequency of } w \text{ in document } k = \frac{\text{Count of }w\text{ in document }k}{\text{Total tokens in document } k} $$

## Building a vocabulary

An important featurization step is to build a vocabulary of words:

- Compute document frequencies for all words
- Inspect low-frequency words and determine a minimum document threshold.
  - e.g., 10 documents, or .25% of documents.

Can also impose more complex thresholds, e.g.:

- appears twice in at least 20 documents
- appears in at least 3 documents in at least 5 years

Assign numerical identifiers to tokens to increase speed and reduce disk usage.

## TF-IDF Weighting

- TF/IDF: “Term-Frequency / Inverse-Document-Frequency.”
- The formula for word $w$ in document $k$:

$$
\text{TF-IDF} = \frac{\text{Term Frequency of }w\text{ in document }k}{\text{Total tokens in document } k} \times \log \frac{\text{Total number of documents}}{\text{Document count of }w}
$$

- The formula up-weights relatively rare words that do not appear in all documents.
  - These words are probably more distinctive of topics or differences between documents.

```
Example: A document contains 100 words, and the word appears 3 times in the document.
The TF is .03. The corpus has 100 documents, and the word appears in 10 documents.
the IDF is 0log(100/10) ≈ 2.3, so the TF-IDF for this document is .03×2.3 = .07.
Say the word appears in 90 out of 100 documents:
Then the IDF is 0.105, with TF-IDF for this document equal to .003.
```

## scikit-learn’s TfidfVectorizer

- corpus is a sequence of strings, e.g. pandas data-frame columns.
- I pre-processing options: strip accents, lowercase, drop stopwords,
- n-grams: can produce phrases up to length n (words or characters).
- vocab options: min/max frequency, vocab size
- post-processing: binary, l2 norm, (smoothed) idf weighting, etc

```python
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.datasets import fetch_20newsgroups

categories = ["alt.atheism", "soc.religion.christian", "comp.graphics", "sci.med"]

twenty_train = fetch_20newsgroups(
    subset="train", categories=categories, shuffle=True, random_state=42
)

tfidf = TfidfVectorizer(
    sublinear_tf=True,
    min_df=5,
    norm="l2",
    encoding="latin-1",
    ngram_range=(1, 2),
    stop_words="english",
)

features = tfidf.fit_transform(twenty_train.data).toarray()

print(features.shape)
# print(tfidf.get_feature_names())
```

## Other Transformations

- Could add log counts, quadratics in counts, etc.
- Could also add pairwise interactions bet ween word counts/frequencies.
- These often are not done much because of the dimensionality problem.
- Could use PCA to reduce dimensionality, but this is a lossy transformation.
