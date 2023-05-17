# Tokenization

```{image} figs/entelecheia_puzzle_pieces.png
:alt: tokenization
:class: bg-primary mb-1
:width: 80%
:align: center
```

Tokenization is a crucial first step in the NLP pipeline. It determines how the input text is represented to the model, which can significantly impact the model's performance. Understanding the different methods of tokenization and their strengths and weaknesses can help in choosing the right approach for a given task. Whether it's word, character, or subword tokenization, the goal is to transform the text into a format that can be effectively processed by machine learning algorithms.

## Introduction

The ultimate objective of NLP is to read, decipher, understand, and make sense of human language in a valuable way. To achieve this, NLP systems typically consist of three main components:

1. **Tokenization**: This is the process of splitting a string into a list of tokens.
2. **Embedding**: This involves mapping tokens to vectors that can be processed by machine learning algorithms.
3. **Model**: This is a neural network that takes token vectors as input and outputs predictions.

In this lecture, we will focus on the first step in the NLP pipeline - Tokenization.

## What is Tokenization?

Tokenization is the process of breaking down text into smaller units, known as tokens. Tokens can be words, characters, or subwords. For instance, the sentence "I like to eat apples" can be tokenized into the list of tokens `["I", "like", "to", "eat", "apples"]`.

In the context of deep learning, tokenization is the process of converting a sequence of characters into a sequence of tokens. Each token is then converted into a numerical vector to be used as input to a neural network.

## Why is Tokenization Important?

Machines do not understand language, sounds, or phonetics. They need to be taught from scratch. Tokenization is the first step in this process. It breaks down the sentence into smaller units that the machine can process. The way the input is represented to the model has a significant impact on the performance of the model.

## Methods of Tokenization

There are three primary methods of tokenization:

1. **Word-level tokenization**: This method splits a sentence into words. It's also known as white space tokenization. For example, "I like to eat apples" becomes `["I", "like", "to", "eat", "apples"]`.

2. **Character-level tokenization**: This method splits a sentence into characters. For example, "I like to eat apples" becomes `["I", " ", "l", "i", "k", "e", " ", "t", "o", " ", "e", "a", "t", " ", "a", "p", "p", "l", "e", "s"]`.

3. **Subword-level tokenization**: This method splits a sentence into subwords. For example, "I like to eat pineapples" becomes `["I", "like", "to", "eat", "pine", "##app", "##les"]`.

Each method has its strengths and weaknesses, and the choice of method depends on the specific requirements of the task at hand.

## Word Tokenization

Word tokenization is the simplest method and is very fast and easy to implement. However, it has some limitations. For instance, it may not recognize variants of words that were not in the training set, leading to out-of-vocabulary (OOV) words. It may also struggle with punctuation, abbreviations, slang, and informal language. Moreover, it may not work well for languages that do not use spaces to separate words, such as Chinese, Japanese, and Korean.

## Character Tokenization

Character tokenization addresses some of the limitations of word tokenization, but it also has its own challenges. For example, it can result in a very large number of tokens, requiring more computation and memory. It may also limit the types of models that can be used and may be inefficient for certain applications. Furthermore, it may struggle to understand the relationship between tokens,

and it could generate incorrect spelling or interpretations.

## Subword Tokenization

Subword tokenization aims to strike a balance between word and character tokenization. It retains the semantic features of words while avoiding the problem of out-of-vocabulary (OOV) words. It breaks down words into smaller, meaningful units or subwords. For example, the word "pineapples" can be tokenized into `["pine", "##app", "##les"]`. This method allows the model to handle any word, even if it was not present in the training set, as long as its subwords were present. This makes it particularly useful for handling rare and complex words, as well as languages that do not use spaces to separate words.

## Next

```{tableofcontents}

```
