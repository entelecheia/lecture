# Vector Semantics

## Introduction

Vector semantics deals with the study of how to represent the meaning of words in vector form, focusing on two primary aspects: lexical semantics and distributional semantics. This is based on the distributional hypothesis, which states that words that occur in similar contexts have similar meanings.

## Lexical Semantics

In the realm of **lexical semantics**, we're focused on the study of the meaning of words. This approach aims to mirror the lexicographic tradition, capturing the same kind of information that would be represented in lexical entries in dictionaries.

For instance, the word "cassoulet" could be represented in different ways:

- A French dish
- A food item containing meat and beans
- A stew

Each of these representations offers a unique aspect of the word's meaning. The same can be said for the word "bar":

- A place where you can drink alcohol
- A long rod
- To prevent something from happening

What lexical semantics emphasizes is the complex many-to-many relationship that exists between concepts or word senses and words. It explores relationships between words such as synonyms (e.g. "bar" and "pub"), antonyms (e.g. "bar" and "open"), and connotations (e.g. "bar" and "prison").

Lexical semantics often uses resources such as lexicons, thesauri, and ontologies to capture explicit knowledge about word meanings. It works under the assumption that words have discrete senses that can be captured in a lexicon. However, while it may capture explicit knowledge about word meanings, it's limited in its ability to capture the meaning of words not found in the lexicon.

## Distributional Semantics

On the other hand, **distributional semantics** is concerned with understanding the meaning of words based on their distributional properties in large text corpora. The main hypothesis in this field is that words that appear in similar contexts share similar meanings.

Distributional semantics maps words to vector representations that capture the distributional properties of words in a corpus. It uses large volumes of raw text to learn the meaning of words from their context. These representations are dense, as opposed to sparse, which gives rise to word embeddings.

### The Distributional Hypothesis

A core assumption that underpins many of the vector-based methods in Natural Language Processing (NLP) is the Distributional Hypothesis. This hypothesis, originating from the field of linguistics, provides a framework for understanding word meaning based on the contexts in which words are used.

The Distributional Hypothesis was originally proposed by {cite:t}`harris1954distributional` and further developed by others, notably by {cite:t}`firth1957synopsis`. The hypothesis essentially posits that **words that occur in similar contexts have similar meanings**. This is often summed up as **"you shall know a word by the company it keeps."**

Consider two words: `oculist` and `eye doctor`. Both of these terms often occur in similar contexts: they may be followed by words like 'examined', 'prescribed', or 'diagnosed'. According to the Distributional Hypothesis, we can infer that `oculist` and `eye doctor` have similar meanings due to these shared contexts.

This hypothesis does not mean that words with similar contexts have the exact same meaning, but rather they share some semantic properties. It's an essential premise for many NLP tasks, especially those involving unsupervised learning from large amounts of text.

### Importance in Word Representation

The Distributional Hypothesis has far-reaching implications for how we choose to represent words in NLP.

Consider an unfamiliar word: `tezgüino`. Without knowing its meaning, we can still gather some understanding by examining its context:

- A bottle of `tezgüino` is on the table.
- Everybody likes `tezgüino`.
- `Tezgüino` makes you drunk.
- We make `tezgüino` out of corn.

These contexts suggest that `tezgüino` is a type of drink, similar to `wine` or `beer`.

Word embeddings, or dense vector representations of words, directly apply the Distributional Hypothesis by learning word meanings from their usage in large bodies of text. Algorithms like Word2Vec, GloVe, or fastText train on massive corpora of text, learning to predict a word from its context (or vice versa). This results in words that appear in similar contexts being mapped to similar points in the vector space, effectively capturing the idea proposed by the Distributional Hypothesis.

## How do we Represent Words to Capture Word Similarities?

Understanding the meaning of words and their relationship to one another is one of the core challenges in Natural Language Processing (NLP). How do we represent words in a way that captures their similarities and differences?

There are three main ways we can represent words to capture word similarities: atomic symbols, sparse vectors, and dense vectors.

### 1. Atomic Symbols

The first approach treats each word as a unique, distinct entity, akin to an atomic symbol. This can be likened to traditional n-gram language models or the use of explicit features in a machine learning model. In this model, each word is considered a discrete, unrelated entity. For instance, in a one-hot encoded vector space, each word would have a unique vector, with a value of 1 in its unique index and 0s everywhere else.

For example:

- "aardvark" could be represented as [1,0,...,0]
- "bear" as [0,1,...,0], and so on.

This makes it easy to identify individual words, but it fails to capture any meaningful relationships between words. For instance, in such a representation, the words "height" and "tall" are as distinct as "aardvark" and "zebra", even though intuitively we understand that "height" and "tall" share semantic similarities.

### 2. Sparse Vectors

The next step up from atomic symbols is to use high-dimensional sparse vectors, like those seen in bag-of-words or tf-idf models. In these models, the dimensions of the vector space correspond to specific words in a predefined vocabulary, and the value at each dimension corresponds to the count or frequency of the word in a given context (such as a document).

While this approach does capture some context by noting which words occur together in the same document, it is still very high-dimensional (the size of the vocabulary) and does not capture much semantic or syntactic similarity between words.

### 3. Dense Vectors (Word Embeddings)

The most advanced approach is to use low-dimensional dense vectors, also known as word embeddings. Word embeddings are representations of words in a dense vector space that capture semantic and syntactic relationships between words.

In this space, similar words are close together, and the spatial relationships between words can capture meaningful relationships. For example, the famous analogy "man is to king as woman is to queen" can be approximately encoded by the vector equation "king - man + woman ≈ queen".

Word embeddings are usually learned using large amounts of text data and machine learning algorithms such as Word2Vec, GloVe, or fastText. These algorithms work by learning to predict a word from its context (or vice versa), such that words that appear in similar contexts end up with similar vector representations.

## Conclusion

Each method of word representation has its strengths and weaknesses, and the appropriate choice depends on the specific task at hand. Atomic symbols and sparse vectors are simple to implement and understand, but they do not capture much meaningful information about word relationships.

On the other hand, dense vectors or word embeddings are more complex but provide a powerful way to represent words that capture many aspects of their meaning. They have proven extremely useful in a wide range of NLP tasks, including text classification, sentiment analysis, machine translation, and more.
