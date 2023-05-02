# mC4 Dataset

by {cite}`xue2020mt5`

The **mC4 dataset** is a multilingual colossal, cleaned version of Common Crawl's web crawl corpus, which is based on the Common Crawl dataset. The dataset includes 108 languages and is specifically designed to pretrain language models and word representations. This dataset is an extension of the C4 dataset, which was designed to be English-only.

```{figure} figs/mc4.png
---
width: 90%
name: fig-mc4
---
mC4 Dataset
```

## Dataset Construction

To build the mC4 dataset, the authors made use of all the 71 monthly web scrapes released so far by Common Crawl, which is dramatically more source data than was used for C4. They used **cld3** to identify over 100 languages and applied several filtering steps, such as line length filter and deduplication, to clean and preprocess the data. After the filtering steps, they grouped the remaining pages by language and included all languages with 10,000 or more pages in the final dataset.

## Building the Dataset

To build the mC4 dataset, follow these steps:

1. Collect data from the Common Crawl dataset by making use of all 71 monthly web scrapes.
2. Use cld3 to identify over 100 languages.
3. Apply a line length filter that requires pages to contain at least three lines of text with 200 or more characters.
4. Deduplicate lines across documents and remove pages containing bad words.
5. Detect each page's primary language using cld3 and remove those with a confidence below 70%.
6. Group the remaining pages by language and include in the corpus all languages with 10,000 or more pages.

After completing these steps, you'll have the mC4 dataset, which contains text in 107 languages as defined by cld3.

## Data Description

The dataset includes the following fields:

- **url**: URL of the source as a string
- **text**: Text content as a string
- **timestamp**: Timestamp as a string

### Supported Languages

The mC4 dataset supports 108 languages, including languages written in the Latin script (denoted by "-Latn").

## Using mC4 Dataset with Hugging Face Datasets Library

You can load the mC4 subset of any language like this:

```python
from datasets import load_dataset

en_mc4 = load_dataset("mc4", "en")
```

And if you want to specify a list of languages:

```python
from datasets import load_dataset

mc4_subset_with_five_languages = load_dataset("mc4", languages=["en", "fr", "es", "de", "zh"])
```
