# Word Embeddings

![](figs/embeddings.png)

## What are word embeddings?

Word embeddings are a way of representing words as vectors. The vectors are learned from text data and are able to capture some of the semantic and systactic information of the words.

For example, the word `cat` is similar to `dog` from the following sentences:

"The cat is lying on the floor and the dog was eating”,

"The doc was lying on the floor and the cat was eating”

In a mathematical sense, a word embedding is a parameterized function of the word:

$$ f\_{\theta}(w) = \theta $$

where $\theta$ is a vector of real numbers. The vector $\theta$ is the embedding of the word $w$.

In a broad sense, `embedding` refers to a lower-dimensional dense vector representation of a higher-dimensional object.

- in NLP, this higher-dimensional object will be a document.
- in computer vision, this higher-dimensional object will be an image.

Examples of embeddings and non-embeddings:

- **Non-embeddings**:
  - one-hot encoding, bag-of-words, TF-IDF, etc.
  - counts over LIWC dictionary categories.
  - sklearn CountVectorizer count vectors
- **Embeddings**:
  - word2vec, GloVe, BERT, ELMo, etc.
  - PCA reductions of the word count vectors
  - LDA topic shares
  - compressed encodings from an autoencoder

## Categorical Embeddings

![](figs/1.png)

Categorical embeddings are a way of representing categorical variables as vectors.

For a binary classification problem with outcome $Y$:

- If you have a high-dimensional categorical variable $X$, (e.g. 1000 categories), you can represent $X$ as a vector of length 1000.
- It is computationally expensive for a ML model to learn from a high-dimensional categorical variable.

Instead, you can represent $X$ as a lower-dimensional vector of length $k$ (e.g. 10). This is called a categorical embedding.

Embedding approaches:

1. PCA applied to the dummy variables $X$ to get a lower-dimensional vector representation of $\tilde{X}$.
2. Regress $Y$ on $X$, predict $\hat{Y}(X_i)$, use that as a feature in a new model.

### An embedding layer is matrix multiplication:

$$
\underbrace{h_1}_{n_E \times 1} = \underbrace{\omega_E}_{n_E \times n_W} \cdot \underbrace{x}_{n_x \times 1}
$$

- $x$ = a categorical variable (e.g., representing a word)
  - One-hot vector with a single item equaling one.
  - Input to the embedding layer.
- $h_1$ = the first hidden layer of the neural net
  - The output of the embedding layer.
- The embedding matrix $\omega_E$ encodes predictive information about the categories.
- It has a spatial interpretation when projected into 2D space.
  - Each row of $\omega_E$ is a vector in $n_E$-dimensional space.
  - The rows of $\omega_E$ are the coordinates of the points in the vector space.
  - The points are the categories.
  - The distance between the points is the similarity between the categories.
  - The angle between the points is the relationship between the categories.

### Embedding Layers versus Dense Layers

An embedding layer is statistically equivalent to a fully-connected dense layer with one-hot vectors as input and linear activation.

- Embedding layers are much faster for many categories (>~50)

## Word Embeddings

> Word embeddings are neural network layers that map words to dense vectors.

Documents are lists of word indexes ${w_1 ,w_2 ,...,w_{n_i} }$.

- Let $w_i$ be a one-hot vector (dimensionality $n_w$ = vocab size) where the associated word’s index equals one.
- Normalize all documents to the same length L; shorter documents can be padded with a null token.
- This requirement can be relaxed with recurrent neural networks.

The embedding layer replaces the list of sparse one-hot vectors with a list of n E -dimensional ($n_E$ << $n_w$ ) dense vectors

$$ \mathbf{X} = [x_1 \ldots x_L ] $$

where

$$
\underbrace{x_j}_{n_E \times 1} = \underbrace{\mathbf{E}}_{n_E \times n_W} \cdot \underbrace{w_j}_{n_w \times 1}
$$

$\mathbf{E}$ a matrix of word vectors. The column associated with the word at $j$ is selected by the dot-product with one-hot vector $w_j$.

$\mathbf{X}$ is flattened into an $L * n_E$ vector for input to the next layer.

![](figs/4.png)

### Why do we need neural networks for word embeddings?

There are a lot of shallow algorithms that work well for clustering.

- k-means
- hierarchical clustering
- spectral clustering
- PCA

The reasons we use neural networks for word embeddings are:

- They are able to learn the relationships between words.
- They can be used as input to a downstream task.
- They create a mapping of discrete words to continuous vectors.
- They solve the curse of dimensionality.

## Next

```{tableofcontents}

```
