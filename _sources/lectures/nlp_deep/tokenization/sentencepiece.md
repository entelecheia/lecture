# SentencePiece Tokenizer

```{image} figs/entelecheia_alphabets.png
:alt: alphabets
:class: bg-primary mb-1
:width: 80%
:align: center
```

## What is SentencePiece?

SentencePiece is a unique approach towards tokenization, which is a crucial preprocessing step in Natural Language Processing (NLP). Unlike traditional tokenizers that primarily focus on space-based or syntax-based token splitting, SentencePiece takes an unsupervised approach, which means it doesn't rely on pre-specified rules. It's mainly used in the realm of Neural Network-based text generation, where it's necessary to predefine the vocabulary size before training the model.

The core concept behind SentencePiece is the implementation of "subword units." This concept is a cornerstone in the tokenization strategies like Byte-Pair-Encoding (BPE) {cite}`sennrich-etal-2016-neural` and the Unigram Language Model {cite}`kudo2018subword`.

- BPE is a subword tokenization method that iteratively merges frequent pairs of characters. By splitting words into subwords, BPE allows the sharing of common parts among words, e.g., 'apple' can be split into 'ap-' and '-ple', where '-ple' could be a common subword in words like 'example', 'simple', etc. This reduces the vocabulary size and allows the model to handle unknown words better.

- The Unigram Language Model is another subword tokenization method that uses a probabilistic model to select the best subword. It proposes several segmentations of the input sentence and chooses the most probable one.

SentencePiece uniquely combines these two strategies and provides an extended method for training these models directly from raw sentences. This is a significant shift from other tokenizers that often require language-specific preprocessing.

In a nutshell, SentencePiece can be considered not as a tokenizer, but as a tool to train the tokenizer itself. It aims to optimize the selection of the most beneficial subword units from the corpus. Additionally, SentencePiece implements the Subword Regularization algorithm, which introduces variability in the tokenization process to make the model more robust.

Finally, SentencePiece is a general-purpose tokenizer, meaning it doesn't have any specific language dependencies and can be used for any language, making it extremely versatile and valuable for multilingual NLP tasks.

## Technical highlights

**Purely Data-Driven**: SentencePiece operates by training tokenization and detokenization models directly from the input sentences. This makes it an end-to-end system, which eliminates the need for pre-tokenization. Pre-tokenization typically involves the use of tools like the Moses tokenizer, MeCab, or KyTea. This data-driven approach simplifies the tokenization process and reduces the potential for errors associated with manual, rule-based tokenization.

**Language Independent**: SentencePiece does not incorporate any language-specific logic. It treats input sentences purely as sequences of Unicode characters. This feature makes SentencePiece a versatile tool for tokenization, as it can handle text data in any language.

**Multiple Subword Algorithms**: SentencePiece supports both Byte Pair Encoding (BPE) and unigram language model algorithms for subword tokenization. BPE is a popular method that merges the most frequent pair of characters iteratively. The unigram language model, on the other hand, is a probabilistic model that chooses the most probable segmentation of the input sentence.

**Subword Regularization**: SentencePiece incorporates subword sampling for subword regularization and BPE-dropout. Subword regularization is a technique that introduces randomness in the choice of subwords, which helps improve the robustness and accuracy of Neural Machine Translation (NMT) models. BPE-dropout is a variant of this, specifically designed for BPE.

**Fast and Lightweight**: SentencePiece is designed to be both efficient and light on resources. It can process around 50,000 sentences per second and only requires about 6MB of memory, making it a suitable choice for large-scale language processing tasks.

**Self-Contained**: SentencePiece provides a self-contained tokenization and detokenization system. This means that as long as the same model file is used, the system will consistently produce the same tokenization and detokenization output. This consistency is crucial in machine learning and NLP projects.

**Direct Vocabulary ID Generation**: In addition to tokenizing text, SentencePiece can also map vocabulary to specific IDs, generating sequences of these IDs directly from raw sentences. This built-in functionality can streamline the processing pipeline by eliminating the need for separate vocabulary-to-ID mapping steps.

**NFKC-based Normalization**: SentencePiece performs text normalization based on NFKC (Normalization Form KC: Compatibility Composition). NFKC is a Unicode normalization method that transforms different representations of equivalent text into a single, standardized form. This normalization is crucial for ensuring consistency and reducing complexity in text data.

**Comparisons with other implementations**

| Feature                                 |      SentencePiece       | subword-nmt |    WordPiece    |
| :-------------------------------------- | :----------------------: | :---------: | :-------------: |
| Supported algorithm                     | BPE, unigram, char, word |     BPE     |      BPE\*      |
| OSS?                                    |           Yes            |     Yes     | Google internal |
| Subword regularization                  |           Yes            |     No      |       No        |
| Python Library (pip)                    |           Yes            |     No      |       N/A       |
| C++ Library                             |           Yes            |     No      |       N/A       |
| Pre-segmentation required?              |            No            |     Yes     |       Yes       |
| Customizable normalization (e.g., NFKC) |           Yes            |     No      |       N/A       |
| Direct id generation                    |           Yes            |     No      |       N/A       |

Note that BPE algorithm used in WordPiece is slightly different from the original BPE.

## High level differences between SentencePiece and other tokenizers

### Predetermined Number of Unique Tokens

Unlike most unsupervised word segmentation algorithms, which assume an infinite vocabulary, SentencePiece operates with a predetermined, fixed vocabulary size. This characteristic aligns well with Neural Machine Translation (NMT) models that typically work with a fixed vocabulary. For instance, SentencePiece's final vocabulary size might be 8k, 16k, or 32k, which is decided before training. It's worth noting that SentencePiece's approach differs from tools like subword-nmt, which use the number of merge operations, a parameter specific to BPE and not applicable to other segmentation algorithms like unigram, word, and character.

### Training from Raw Sentences

Unlike many previous subword implementations that require pre-tokenized input sentences for efficient training, SentencePiece can train directly from raw sentences. This capability simplifies the preprocessing stage, eliminating the need for running language-specific tokenizers beforehand. This feature is especially valuable for languages like Chinese and Japanese, where there are no explicit spaces between words.

### Whitespace as a Basic Symbol

SentencePiece treats the input text as a sequence of Unicode characters, including whitespace as a normal symbol. This treatment is crucial for achieving a reversible conversion between the original input and tokenized sequence. To make this possible, SentencePiece first substitutes whitespace with a meta symbol "▁" (U+2581). After segmenting the text into smaller pieces, the whitespace can be restored, allowing for unambiguous detokenization. This feature makes SentencePiece language-agnostic in terms of detokenization.

- For example, a standard English tokenizer would segment the text "Hello world." into the following three tokens.

  > [Hello] [World] [.]

- One observation is that the original input and tokenized sequence are **NOT reversibly convertible**.
- For instance, the information that is no space between “World” and “.” is dropped from the tokenized sequence, since e.g., `Tokenize(“World.”) == Tokenize(“World .”)`

- SentencePiece treats the input text just as a sequence of Unicode characters. Whitespace is also handled as a normal symbol.
- To handle the whitespace as a basic token explicitly, SentencePiece first escapes the whitespace with a meta symbol "▁" (U+2581) as follows.

  > Hello▁World.

- Then, this text is segmented into small pieces, for example:

  > [Hello] [▁Wor] [ld] [.]

- Since the whitespace is preserved in the segmented text, we can detokenize the text without any ambiguities.

  ```python
  detokenized = ''.join(pieces).replace('▁', ' ')
  ```

- This feature makes it possible to perform detokenization without relying on language-specific resources.

Note that we cannot apply the same lossless conversions when splitting the sentence with standard word segmenters, since they treat the whitespace as a special symbol. Tokenized sequences do not preserve the necessary information to restore the original sentence.

- (en) Hello world. → [Hello] [World] [.] \(A space between Hello and World\)
- (ja) こんにちは世界。 → [こんにちは] [世界] [。] \(No space between こんにちは and 世界\)

### Subword regularization and BPE-dropout

SentencePiece implements regularization methods like subword regularization and BPE-dropout. Subword regularization is an on-the-fly subword sampling technique that virtually augments training data, improving the accuracy and robustness of NMT models. BPE-dropout is a variant of this, specifically designed for BPE. To use subword regularization, the SentencePiece library needs to be integrated into the NMT system, allowing the sampling of one segmentation for each parameter update. This process differs from standard offline data preparations. For example, a term like 'New York' might be segmented differently on each encoding call when sampling is enabled.

## Subword Regularization in NMT

**Subword Regularization** refers to a technique used in neural machine translation (NMT) that can virtually augment training data and improve the accuracy and robustness of NMT models. It involves working with subword sequences and takes into account the multiple ways a word could be segmented into subwords.

Let's break down the concepts and the formulas given:

1. **Sequence Probability**: If we have a sequence of unigrams (individual units of a language, which can be as small as a character or as large as a word) $X = (x_1, x_2, \cdots, x_n)$, the probability of sequence $X$ is given by the product of the conditional probabilities of each unigram. This is derived from the Bayes chain rule:

$$
P(X) = p(x_1) p(x_2 | x_1) \cdots p(x_n | x_1, \cdots, x_{n-1}) = \prod_{i=1}^n p(x_i | x_1, \cdots, x_{i-1})
$$

This formula suggests that the probability of a sequence is the product of the probabilities of each token in the sequence, given all the tokens that came before it.

2. **Probability in Neural Machine Translation**: In NMT, we are often interested in the probability of a target sequence $Y$ given a source sequence $X$. This is given by the product of the conditional probabilities of each token in the target sequence, given the source sequence and all previous target tokens:

$$
P(Y|X;\theta) = \prod_{i=1}^n P(y_i | \mathbf{x}, y_{<i}; \theta)
$$

Here, lowercase variables represent actual tokens, uppercase variables represent sequences of tokens, and $\theta$ represents the model parameters.

3. **Subword Sequences**: The formulas above oversimplify the problem, as they do not account for the fact that both $X$ and $Y$ can be formed from an exponentially large number of possible subword sequences. For instance, the word `hello` could be segmented in numerous ways, including `h e l l o`, `he ll o`, `hel lo`, `hell o`, and `hello`. To account for this, we replace $X$ and $Y$ with specific sequences of subwords, $\mathbf{x}$ and $\mathbf{y}$.

4. **Cost Function for NMT**: The cost function, or loss function, for NMT is given by the negative sum of the expected log-likelihood of the target subword sequence $\mathbf{y}$ given the source subword sequence $\mathbf{x}$:

$$
\mathcal{L}(\theta) = - \sum_{s=1}^{|D|} \mathbb{E}_{\substack{\mathbf{x} \sim P(\mathbf{x}|X^{(s)}) \\ \mathbf{y} \sim P(\mathbf{y}|Y^{(s)})}} \log P(\mathbf{y}|\mathbf{x};\theta)
$$

Here, $D$ is the set of training examples, and the expectation is taken over all possible subword sequences $\mathbf{x}$ and $\mathbf{y}$ that can be formed from source $X^{(s)}$ and target $Y^{(s)}$ sentences, respectively. In practice, we can approximate this expected log-likelihood for a single training example $(\mathbf{x}, \mathbf{y})$.

Subword regularization essentially leverages the variability in subword segmentations to diversify the training data for NMT models, leading to more robust models that generalize better to unseen data.

## Usage

**Installation**

SentencePiece is a Python library, which can be installed via pip:

```bash
pip install sentencepiece
```

**Training a SentencePiece Model**

The SentencePiece model is trained on a given text corpus. The training process identifies the most common subword units, which will then be used for tokenization. Here's an example of training a SentencePiece model:

```python
import sentencepiece as spm

spm.SentencePieceTrainer.train(
    "--input=../data/sentencepiece/botchan.txt --model_prefix=m --vocab_size=2000"
)
```

Here's what each parameter does:

- `--input`: This is the path to the file containing the training corpus. The model will be trained on this text.

- `--model_prefix`: This is the prefix of the output model file. In this case, the model file will be named "m.model".

- `--vocab_size`: This is the size of the vocabulary. The model will use the 2000 most common subword units.

The training process also logs various information to the console about the training process, such as the size of the alphabet and the character coverage.

```
sentencepiece_trainer.cc(177) LOG(INFO) Running command: --input=../data/sentencepiece/botchan.txt --model_prefix=m --vocab_size=2000
sentencepiece_trainer.cc(77) LOG(INFO) Starts training with :
trainer_spec {
input: ../data/sentencepiece/botchan.txt
input_format:
model_prefix: m
model_type: UNIGRAM
vocab_size: 2000
self_test_sample_size: 0
character_coverage: 0.9995
input_sentence_size: 0
shuffle_input_sentence: 1
seed_sentencepiece_size: 1000000
shrinking_factor: 0.75
max_sentence_length: 4192
num_threads: 16
num_sub_iterations: 2
max_sentencepiece_length: 16
split_by_unicode_script: 1
split_by_number: 1
split_by_whitespace: 1
split_digits: 0
treat_whitespace_as_suffix: 0
allow_whitespace_only_pieces: 0
required_chars:
byte_fallback: 0
vocabulary_output_piece_score: 1
train_extremely_large_corpus: 0
hard_vocab_limit: 1
use_all_vocab: 0
unk_id: 0
bos_id: 1
eos_id: 2
pad_id: -1
unk_piece: <unk>
bos_piece: <s>
eos_piece: </s>
pad_piece: <pad>
unk_surface: ⁇
enable_differential_privacy: 0
differential_privacy_noise_level: 0
differential_privacy_clipping_threshold: 0
}
normalizer_spec {
name: nmt_nfkc
add_dummy_prefix: 1
remove_extra_whitespaces: 1
escape_whitespaces: 1
normalization_rule_tsv:
}
denormalizer_spec {}
trainer_interface.cc(350) LOG(INFO) SentenceIterator is not specified. Using MultiFileSentenceIterator.
trainer_interface.cc(181) LOG(INFO) Loading corpus: ../data/sentencepiece/botchan.txt
trainer_interface.cc(406) LOG(INFO) Loaded all 4288 sentences
trainer_interface.cc(422) LOG(INFO) Adding meta_piece: <unk>
trainer_interface.cc(422) LOG(INFO) Adding meta_piece: <s>
trainer_interface.cc(422) LOG(INFO) Adding meta_piece: </s>
trainer_interface.cc(427) LOG(INFO) Normalizing sentences...
trainer_interface.cc(536) LOG(INFO) all chars count=274252
trainer_interface.cc(547) LOG(INFO) Done: 99.957% characters are covered.
trainer_interface.cc(557) LOG(INFO) Alphabet size=69
trainer_interface.cc(558) LOG(INFO) Final character coverage=0.99957
trainer_interface.cc(590) LOG(INFO) Done! preprocessed 4288 sentences.
unigram_model_trainer.cc(146) LOG(INFO) Making suffix array...
unigram_model_trainer.cc(150) LOG(INFO) Extracting frequent sub strings...
unigram_model_trainer.cc(201) LOG(INFO) Initialized 16112 seed sentencepieces
trainer_interface.cc(596) LOG(INFO) Tokenizing input sentences with whitespace: 4288
trainer_interface.cc(607) LOG(INFO) Done! 9165
unigram_model_trainer.cc(491) LOG(INFO) Using 9165 sentences for EM training
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=0 size=5926 obj=10.5283 num_tokens=18931 num_tokens/piece=3.19457
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=1 size=5232 obj=8.64492 num_tokens=19009 num_tokens/piece=3.63322
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=0 size=3923 obj=8.71868 num_tokens=20446 num_tokens/piece=5.21183
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=1 size=3922 obj=8.66277 num_tokens=20447 num_tokens/piece=5.21341
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=0 size=2941 obj=8.95617 num_tokens=22741 num_tokens/piece=7.7324
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=1 size=2941 obj=8.88103 num_tokens=22745 num_tokens/piece=7.73376
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=0 size=2205 obj=9.26224 num_tokens=25461 num_tokens/piece=11.5469
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=1 size=2205 obj=9.17719 num_tokens=25457 num_tokens/piece=11.5451
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=0 size=2200 obj=9.17892 num_tokens=25475 num_tokens/piece=11.5795
unigram_model_trainer.cc(507) LOG(INFO) EM sub_iter=1 size=2200 obj=9.17823 num_tokens=25475 num_tokens/piece=11.5795
trainer_interface.cc(685) LOG(INFO) Saving model: m.model
trainer_interface.cc(697) LOG(INFO) Saving vocabs: m.vocab
```

**Loading and Using the SentencePiece Model**

Once the model is trained, it can be loaded and used to tokenize text:

```python
s = spm.SentencePieceProcessor()
s.load("m.model")

for n in range(5):
    print(
        s.encode(
            "New York", out_type=str, enable_sampling=True, alpha=0.1, nbest_size=-1
        )
    )
```

In this example, "New York" is tokenized 5 times. The `enable_sampling=True` parameter allows SentencePiece to return multiple possible segmentations of the same text, and `alpha` and `nbest_size` parameters control the sampling algorithm.

The output is a list of subword units for each tokenization:

```
['▁New', '▁Y', 'or', 'k']
['▁N', 'e', 'w', '▁Y', 'o', 'r', 'k']
['▁New', '▁Y', 'o', 'r', 'k']
['▁N', 'e', 'w', '▁Y', 'o', 'r', 'k']
['▁', 'N', 'e', 'w', '▁Y', 'or', 'k']
```

Each list is a different way of segmenting "New York" into subword units. This shows the power of SentencePiece and subword regularization in handling various possible subword segmentations.
