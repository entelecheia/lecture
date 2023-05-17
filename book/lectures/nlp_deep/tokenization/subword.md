# Subword Tokenization

Subword tokenization is a powerful tool in the NLP toolkit. It provides a flexible and efficient way to represent text, allowing models to handle a wide range of words and languages. By understanding and effectively implementing subword tokenization, we can build more robust and versatile NLP models. In the next lecture, we will explore the next step in the NLP pipeline - Embedding, where we map these subword tokens to vectors that can be processed by machine learning algorithms.

## Introduction

In our previous lecture, we discussed the concept of tokenization, a crucial first step in the Natural Language Processing (NLP) pipeline. We explored different methods of tokenization, including word-level and character-level tokenization. Today, we will delve deeper into a more nuanced method of tokenization known as subword tokenization.

## What is Subword Tokenization?

Subword tokenization is a method that breaks down words into smaller, meaningful units or subwords. For instance, the word "pineapples" can be tokenized into `["pine", "##app", "##les"]`. This method allows the model to handle any word, even if it was not present in the training set, as long as its subwords were present.

Subword tokenization aims to strike a balance between word and character tokenization. It retains the semantic features of words while avoiding the problem of out-of-vocabulary (OOV) words. This makes it particularly useful for handling rare and complex words, as well as languages that do not use spaces to separate words.

## Why Subword Tokenization?

Subword tokenization addresses some of the key challenges associated with word and character tokenization:

1. **Out-of-vocabulary (OOV) Words**: In word-level tokenization, if a word is not present in the training set, the model will not recognize it during testing. This is known as the OOV problem. Subword tokenization mitigates this issue by breaking down words into smaller units that are likely to be present in the training set.

2. **Large Vocabulary Size**: Word-level tokenization can lead to a large vocabulary size, especially for languages with rich morphology or for tasks with a large number of rare words. Subword tokenization helps control the vocabulary size by representing words as a sequence of subwords.

3. **Semantic Understanding**: Character-level tokenization often fails to capture the semantic meaning of words as it breaks down words into individual characters. Subword tokenization, on the other hand, retains the semantic features of words by breaking them down into meaningful units.

## Algorithms for Subword Tokenization

There are several algorithms that can be used to decide which subwords to use. These include:

1. **Byte Pair Encoding (BPE)**
2. **Byte-level BPE**
3. **WordPiece**
4. **Unigram**
5. **SentencePiece**
6. **Subword Sampling**
7. **BPE-dropout**

Let's explore each of these in detail.

## Byte Pair Encoding (BPE)

Byte Pair Encoding (BPE) is a subword tokenization method proposed by {cite:t}`sennrich-etal-2016-neural`. Originally used for text compression, BPE splits words into sequences of characters and iteratively combines the most frequent character pairs. This results in a fixed-size vocabulary of subwords that can be used to tokenize any text.

The BPE algorithm works as follows:

1. **Extract the words from the given dataset along with their count**: The first step in BPE is to extract all the unique words from the dataset along with their frequency of occurrence. This frequency information is crucial for the algorithm as it decides which character pairs to merge based on their frequency.

2. **Define the vocabulary size**: The next step is to define the size of the vocabulary. This is an important parameter as it determines the number of unique tokens in the final vocabulary.

3. **Split the words into a character sequence**: Each word in the dataset is then split into a sequence of characters. For example, the word "low" would be split into `["l", "o", "w"]`.

4. **Add all the unique characters in our character sequence to the vocabulary**: All the unique characters resulting from the previous step are added to the vocabulary.

5. **Select and merge the symbol pair that has a high frequency**: The algorithm then identifies the pair of symbols that occur together most frequently in the dataset and merges them to form a new token. For example, if the pair of characters "e" and "s" is the most frequent, they would be merged to form a new token "es".

6. **Repeat step 5 until the vocabulary size is reached**: Steps 5 and 6 are repeated until the vocabulary has reached the defined size. The result is a vocabulary that consists of single characters and frequently occurring character pairs.

An important aspect of BPE is the use of a special stop token `</w>`. This token is appended at the end of each word. The presence of this token helps the model distinguish between different uses of the same token. For example, the token "st" could be part of the word "st ar" or "wide st". With the stop token, if there is a token "st</w>", the model immediately knows that it is the token for the word "wide st</w>" but not "st ar</w>".

In summary, BPE is a powerful subword tokenization method that can handle a wide range of words and languages. By understanding and effectively implementing BPE, we can build more robust and versatile NLP models.

### Byte Pair Encoding (BPE) - A Detailed Example

Let's take a closer look at how Byte Pair Encoding (BPE) works with a concrete example. Suppose we have the following frequency count of words in our dataset:

```
{'l o w </w>': 5, 'l o w e r </w>': 2, 'n e w e s t </w>': 6, 'w i d e s t </w>': 3}
```

Each word is split into characters, and a special stop token `</w>` is appended at the end of each word.

#### First Iteration

In the first iteration, we count the frequency of each consecutive byte pair. The pair `e` and `s` occur 6 + 3 = 9 times, which is the most frequent. So, we merge these into a new token `es`. The frequency count of words becomes:

```
{'l o w </w>': 5, 'l o w e r </w>': 2, 'n e w es t </w>': 6, 'w i d es t </w>': 3}
```

#### Second Iteration

In the second iteration, we again count the frequency of each consecutive byte pair. This time, the pair `es` and `t` occur 6 + 3 = 9 times, which is the most frequent. We merge these into a new token `est`. The frequency count of words becomes:

```
{'l o w </w>': 5, 'l o w e r </w>': 2, 'n e w est </w>': 6, 'w i d est </w>': 3}
```

#### Third Iteration

In the third iteration, we find that the pair `est` and `</w>` is the most frequent. We merge these into a new token `est</w>`. The frequency count of words becomes:

```
{'l o w </w>': 5, 'l o w e r </w>': 2, 'n e w est</w>': 6, 'w i d est</w>': 3}
```

We continue this process until we reach the desired number of tokens or the maximum number of iterations.

This example illustrates how BPE iteratively merges the most frequent pairs of characters. This results in a fixed-size vocabulary of subwords that can be used to tokenize any text. The special stop token `</w>` helps distinguish between different uses of the same token, making BPE a powerful tool for subword tokenization.

## Byte-level Byte Pair Encoding (BBPE)

Byte-level BPE is a variant of BPE that splits words into sequences of bytes instead of characters. This allows for a more granular level of tokenization, which can be beneficial for certain tasks.

## WordPiece

WordPiece is a subword tokenization algorithm proposed by Google. It works similarly to BPE, but it merges tokens based on likelihood instead of frequency. The likelihood is calculated using the formula $p(w_{i}, w_{j})/p(w_{i})p(w_{j})$. This approach allows WordPiece to better handle rare and complex words.

## Unigram Language Model

The Unigram Language Model for subword segmentation is a method proposed by {cite:t}`kudo2018subword`. This model outputs multiple subword segmentations along with their probabilities, providing a probabilistic approach to subword tokenization.

### Assumptions and Probability Calculation

The Unigram model operates under the assumption that each subword occurs independently. This means that the occurrence of one subword does not affect the occurrence of another. Given a subword sequence $x=(x_{1}, x_{2}, \cdots, x_{n})$, the probability of the sequence is calculated as the product of the probabilities of each subword: $p(x)=\prod_{i=1}^{n} p(x_{i})$.

For a given sentence $X$, the most probable segmentation $x^*$ is the one that maximizes the probability $P(x)$ over all possible segmentations $S(X)$: $x^*=\underset{x \in S(X)}{\operatorname{argmax}} P(x)$.

### Estimating Subword Occurrence Probabilities

The probabilities of subword occurrence $x_{i}$ are estimated using the Expectation Maximization (EM) algorithm. The EM algorithm is used to maximize the log-likelihood $L$ of the training data $D$:

$$
L=\sum_{s = 1}^{|D|} \log(P(X^{(s)})) = \sum_{s = 1}^{|D|} \log(\sum_{x \in S(X^{(S)})} P(x))
$$

### Obtaining the Vocabulary

The procedure for obtaining the vocabulary $V$ with a desired size is as follows:

1. **Initialize a reasonably big seed vocabulary**: The seed vocabulary should be large enough to capture a wide range of subwords in the corpus.

2. **Define a desired vocabulary size**: This is the target size for the final vocabulary.

3. **Optimize the subword occurrence probabilities using the EM algorithm by fixing the vocabulary**: The EM algorithm is used to adjust the subword occurrence probabilities to maximize the log-likelihood of the training data.

4. **Compute the loss for each subword**: The loss of a subword is the decrease in the log-likelihood $L$ when that subword is removed from the vocabulary.

5. **Sort the subwords by loss and keep the top n% of subwords**: The subwords are ranked by their loss, and the top n% are kept. Subwords with a single character are always kept to avoid the out of vocabulary problem.

6. **Repeat steps 3 to 5 until the desired vocabulary size is reached**: This process is iterated until the vocabulary has been pruned down to the target size.

The most common way to prepare the seed vocabulary is to use the most frequent substrings and characters in the corpus. This ensures that the initial vocabulary is representative of the corpus. The resulting unigram language model based subword segmentation consists of characters, subwords, and words.

In summary, the Unigram Language Model for subword segmentation provides a flexible and probabilistic approach to subword tokenization. By adjusting the desired vocabulary size and the percentage of subwords kept at each iteration, you can fine-tune the granularity of the subword segmentation to suit your specific needs.

## Subword Sampling

Subword Sampling is a method that trains models with multiple subword segmentations based on a unigram language model. These segmentations are probabilistically sampled during training. This approach exposes the models to various subword segmentations, giving them a better understanding of words and subwords.

## BPE-Dropout

BPE-dropout is a subword regularization method based on BPE. It keeps the BPE vocabulary and the merge table as original while changing the segmentation procedure. Some merges are randomly removed with a probability of $p$ at each merge step, thus giving multiple segmentations for the same word. This method exposes the models to various subword segmentations, allowing them to have a better understanding of words and subwords.

## Conclusion

Choosing the right subword tokenization algorithm depends on the specific requirements of the task at hand. Each algorithm has its strengths and weaknesses, and understanding these can help in making an informed decision. Whether it's BPE, WordPiece, Unigram, or any other method, the goal is to transform the text into a format that can be effectively processed by machine learning algorithms.
