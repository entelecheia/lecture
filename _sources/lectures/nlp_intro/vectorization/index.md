# Vector Representation

```{image} figs/entelecheia_alphabet_letters.png
:alt: Vector Representation
:class: bg-primary mb-1
:width: 80%
:align: center
```

## Introduction

In Natural Language Processing (NLP), understanding and representing the meaning of words is a foundational task. Words, phrases, and documents are often transformed into vectors (a mathematical representation) so that a machine learning algorithm can understand and process the information. This method of representing language is commonly known as vector space models.

## Vector Space Models

In a vector space model, every word in a given text is represented as a vector in a multi-dimensional space. The exact dimensionality depends on the size of the vocabulary. Each unique word is assigned a unique vector.

The simplest vector representation is a binary vector, also known as a one-hot vector. In this case, the dimensionality of the vector is equal to the size of the vocabulary. Each word is represented as a vector with all dimensions set to 0, except for one dimension (corresponding to the word itself), which is set to 1.

Although the one-hot vector representation is simple, it is not very efficient or expressive. It does not capture the semantic similarities between words, and it leads to sparse vectors with a high dimensionality. This leads us to the development of more sophisticated methods of vector representation.

## Word Embeddings

Word embeddings are dense vector representations where similar words have similar vectors, and they capture much more information about words. They are capable of capturing context of a word in a document, semantic and syntactic similarity, relation with other words, etc.

There are two popular types of word embeddings, namely Word2Vec and GloVe.

### Word2Vec

Word2Vec, developed by researchers at Google, uses neural networks to learn word associations from a large corpus of text. There are two architectures for implementing Word2Vec:

1. **Continuous Bag-of-Words (CBOW):** In this architecture, the model predicts a target word given a context. A context consists of a few words before and after the target word.

2. **Skip-Gram:** In this architecture, the model uses the target word to predict the context. It works opposite to the CBOW architecture.

The dimensionality of word vectors in Word2Vec is a hyperparameter, and choosing the right number of dimensions is important. Too few dimensions can result in loss of information, while too many can make the vectors sparse, making the computations harder.

### GloVe

Global Vectors for Word Representation (GloVe), developed by researchers at Stanford, combines the benefits of two major models, namely the global statistics of matrix factorization techniques (like LSA) and the local context-based learning in Word2Vec.

Instead of using a window to define local context, GloVe constructs an explicit word-context or word co-occurrence matrix using statistics across the whole text corpus. The main advantage of GloVe is that it can capture both global statistics and local semantics.

## Document Embeddings

While word embeddings provide vector representations for individual words, there are scenarios where we need to represent larger blocks of text, such as sentences, paragraphs, or entire documents. Models like Doc2Vec, FastText, and BERT provide ways to create such embeddings.

### Doc2Vec

Doc2Vec, an extension of Word2Vec, is a model that generates vectors for entire documents, rather than just words. There are two algorithms in Doc2Vec:

1. **Distributed Memory (DM):** This preserves the word order in a document by concatenating them together.

2. **Distributed Bag of Words (DBOW):** This ignores the order of words in the document and averages all vectors.

### FastText

FastText, developed by Facebook's AI Research lab, takes into account the internal structure of words while constructing word vectors, treating each word as composed of character n-

grams. This is especially useful for languages with rich morphology.

### BERT

BERT (Bidirectional Encoder Representations from Transformers), developed by Google, introduces a new approach to obtain context-aware word representations. It uses a Transformer (a model architecture introduced in the paper "Attention is All You Need") to consider the full context of a word by looking at the words that come before and after it.

## Conclusion

Vector representations in NLP have greatly advanced our ability to analyze, understand, and generate human language. Starting from simple one-hot encoding, we now have sophisticated embedding techniques that can capture deep semantic and syntactic relationships between words and even larger pieces of text. These methods are central to many of the most exciting applications in NLP, including machine translation, sentiment analysis, and question answering systems.

## Next

```{tableofcontents}

```
