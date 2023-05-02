# mC4 Dataset

by {cite:t}`xue2020mt5`

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

## Comparison to Related Models

Most related models use Wikipedia as their primary source for multilingual data. However, some models, such as XLM-R and mBART, also leverage data from Common Crawl to expand their training dataset. The mC4 dataset, in contrast, focuses on using data from Common Crawl with a more extensive filtering and cleaning process.

### mBERT

mBERT (Devlin, 2018) is a multilingual version of BERT (Devlin et al., 2019). The primary difference between mBERT and BERT is the training set. While BERT is trained on English Wikipedia and the Toronto Books Corpus, mBERT is trained on up to 104 languages from Wikipedia.

### XLM

XLM (Conneau and Lample, 2019) is based on BERT but applies improved methods for pre-training multilingual language models, including explicitly cross-lingual pre-training objectives. The most massively-multilingual variant of XLM was trained on 100 languages from Wikipedia.

### XLM-R

XLM-R (Conneau et al., 2020) is an improved version of XLM based on the RoBERTa model (Liu et al., 2019). XLM-R is trained with a cross-lingual masked language modeling objective on data in 100 languages from Common Crawl. To improve the pre-training data quality, pages from Common Crawl were filtered by an n-gram language model trained on Wikipedia (Wenzek et al., 2020).

### mBART

mBART (Liu et al., 2020a) is a multilingual encoder-decoder model based on BART (Lewis et al., 2020b). mBART is trained with a combination of span masking and sentence shuffling objectives on a subset of 25 languages from the same data as XLM-R.

### MARGE

MARGE (Lewis et al., 2020a) is a multilingual encoder-decoder model trained to reconstruct a document in one language by retrieving documents in other languages. It uses data in 26 languages from Wikipedia and CC-News (Liu et al., 2019).

```{figure} figs/mc4-comparison.png
---
width: 90%
name: fig-mc4-comparison
---
Comparison of mC4 and other datasets
```

## Data Description

The dataset includes the following fields:

- **url**: URL of the source as a string
- **text**: Text content as a string
- **timestamp**: Timestamp as a string

### Supported Languages

The mC4 dataset supports 108 languages, including languages written in the Latin script (denoted by "-Latn").

| language code | language name        |
| :------------ | :------------------- |
| af            | Afrikaans            |
| am            | Amharic              |
| ar            | Arabic               |
| az            | Azerbaijani          |
| be            | Belarusian           |
| bg            | Bulgarian            |
| bg-Latn       | Bulgarian (Latin)    |
| bn            | Bangla               |
| ca            | Catalan              |
| ceb           | Cebuano              |
| co            | Corsican             |
| cs            | Czech                |
| cy            | Welsh                |
| da            | Danish               |
| de            | German               |
| el            | Greek                |
| el-Latn       | Greek (Latin)        |
| en            | English              |
| eo            | Esperanto            |
| es            | Spanish              |
| et            | Estonian             |
| eu            | Basque               |
| fa            | Persian              |
| fi            | Finnish              |
| fil           | Filipino             |
| fr            | French               |
| fy            | Western Frisian      |
| ga            | Irish                |
| gd            | Scottish Gaelic      |
| gl            | Galician             |
| gu            | Gujarati             |
| ha            | Hausa                |
| haw           | Hawaiian             |
| hi            | Hindi                |
| hi-Latn       | Hindi (Latin script) |
| hmn           | Hmong, Mong          |
| ht            | Haitian              |
| hu            | Hungarian            |
| hy            | Armenian             |
| id            | Indonesian           |
| ig            | Igbo                 |
| is            | Icelandic            |
| it            | Italian              |
| iw            | former Hebrew        |
| ja            | Japanese             |
| ja-Latn       | Japanese (Latin)     |
| jv            | Javanese             |
| ka            | Georgian             |
| kk            | Kazakh               |
| km            | Khmer                |
| kn            | Kannada              |
| ko            | Korean               |
| ku            | Kurdish              |
| ky            | Kyrgyz               |
| la            | Latin                |
| lb            | Luxembourgish        |
| lo            | Lao                  |
| lt            | Lithuanian           |
| lv            | Latvian              |
| mg            | Malagasy             |
| mi            | Maori                |
| mk            | Macedonian           |
| ml            | Malayalam            |
| mn            | Mongolian            |
| mr            | Marathi              |
| ms            | Malay                |
| mt            | Maltese              |
| my            | Burmese              |
| ne            | Nepali               |
| nl            | Dutch                |
| no            | Norwegian            |
| ny            | Nyanja               |
| pa            | Punjabi              |
| pl            | Polish               |
| ps            | Pashto               |
| pt            | Portuguese           |
| ro            | Romanian             |
| ru            | Russian              |
| ru-Latn       | Russian (Latin)      |
| sd            | Sindhi               |
| si            | Sinhala              |
| sk            | Slovak               |
| sl            | Slovenian            |
| sm            | Samoan               |
| sn            | Shona                |
| so            | Somali               |
| sq            | Albanian             |
| sr            | Serbian              |
| st            | Southern Sotho       |
| su            | Sundanese            |
| sv            | Swedish              |
| sw            | Swahili              |
| ta            | Tamil                |
| te            | Telugu               |
| tg            | Tajik                |
| th            | Thai                 |
| tr            | Turkish              |
| uk            | Ukrainian            |
| und           | Unknown language     |
| ur            | Urdu                 |
| uz            | Uzbek                |
| vi            | Vietnamese           |
| xh            | Xhosa                |
| yi            | Yiddish              |
| yo            | Yoruba               |
| zh            | Chinese              |
| zh-Latn       | Chinese (Latin)      |
| zu            | Zulu                 |

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
