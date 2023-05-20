# TF-IDF Model

In today's lecture, we'll discuss an important concept in Natural Language Processing (NLP): Term Frequency-Inverse Document Frequency (TF-IDF). We'll also compare it to the CountVectorizer (also known as the Bag of Words model) and illustrate both with Python code examples.

## What is TF-IDF?

TF-IDF is a statistical measure used to evaluate the importance of a word to a document in a collection or corpus of documents. It is based on the premise that words that are most common in one document but rare in other documents in the corpus may be particularly important to the specific document.

TF-IDF is an acronym for two separate components:

- **Term Frequency (TF)**: This measures the frequency of a word in a document. It's the ratio of the number of times the word appears in the document compared to the total number of words in the document.

- **Inverse Document Frequency (IDF)**: This measures the importance of the word in the corpus. It's calculated as the logarithm of the ratio of the total number of documents in the corpus to the number of documents containing the word.

The TF-IDF value of a word in a document is the product of its TF and IDF values.

## Comparison with CountVectorizer

The Bag of Words model, as implemented by the `CountVectorizer` in Python's `sklearn` library, simply represents text data as the frequency of each word in a document. It does not consider the importance of the word in the document relative to the other documents in the corpus.

On the other hand, TF-IDF assigns a weight to each word based not only on its frequency in a single document but also on its distribution across the entire corpus. This allows it to give more importance to words that are more specific to a particular document.

## Python Code Examples

Let's look at a simple Python code example to illustrate these concepts. We'll use the `sklearn` library for our example.

```python
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer

# Define a small corpus
corpus = [
    'The sky is blue and beautiful.',
    'Love this blue and beautiful sky!',
    'The quick brown fox jumps over the lazy dog.',
    'A king’s breakfast has sausages, ham, bacon, eggs, toast and beans',
    'I love green eggs, ham, sausages and bacon!',
    'The brown fox is quick and the blue dog is lazy!',
    'The sky is very blue and the sky is very beautiful today',
    'The dog is lazy but the brown fox is quick!'
]

# Initialize a CountVectorizer
cv = CountVectorizer()

# Fit and transform the corpus
cv_matrix = cv.fit_transform(corpus)

# Convert the matrix to an array and print it
print("Count Vectorizer:")
print(cv_matrix.toarray())

# Now let's do the same with a TfidfVectorizer
tfidf = TfidfVectorizer()

# Fit and transform the corpus
tfidf_matrix = tfidf.fit_transform(corpus)

# Convert the matrix to an array and print it
print("\nTF-IDF Vectorizer:")
print(tfidf_matrix.toarray())
```

In the above code, we first create a `CountVectorizer` and `fit_transform` our corpus to convert it into a matrix of word counts. Each row in the matrix corresponds to a document in the corpus and each column corresponds to a word in the vocabulary, with the value being the count of the word in the document.

Next, we do the same with a `TfidfVectorizer`. The resulting matrix is similar, but instead of simple word counts, it contains the TF-IDF values for each word in each document.

## Conclusion

While the `CountVectorizer` (or Bag of Words model) provides a simple way to represent text data, it can often result in large, sparse matrices and does not consider the relative importance of words. The TF-IDF model addresses these issues by assigning weights to words based on their importance in the document and the corpus, resulting in a denser and more informative representation of the text data.
