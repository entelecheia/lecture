# Text Preprocessing in Korean

In Natural Language Processing, one of the first and crucial steps is text preprocessing. For Korean text, preprocessing is quite unique and more complicated due to the language's nature and structure. Let's discuss some of these aspects.

## Sentence Tokenization in Korean

Sentence tokenization refers to dividing text into individual sentences, also known as sentence segmentation or sentence boundary detection. In English, this is straightforward using punctuation marks like full stops ('.'), exclamation marks ('!'), or question marks ('?') as boundaries. However, in Korean, this is not as easy due to the different sentence structures and use of punctuation.

For instance, a full stop in Korean can be used in multiple scenarios and not just to denote the end of a sentence. Here are some examples:

```
IP 192.168.56.31 서버에 들어가서 로그 파일 저장해서 aaa@gmail.com로 결과 좀 보내줘. 그 후 점심 먹으러 가자.
```

```
Since I'm actively looking for Ph.D. students, I get the same question a dozen times every year.
```

| 원문     | 나는 그 과자를 먹었다.                                                                  | 너는 그를 사랑하니?                                                                         |
|--------|--------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| 형태소 분석 | 나(대명사) + 는(조사) + 그(대명사) + 과자(명 사) + 먹-(동사)+-었(선어말어미)+- 다(어말 어 미)+ .(문장 부호)     | 너(대명사) + 는(조사) + 그(대명사) + 사랑(명사) +-하(동사)+니(어말 어미) + ? (문장부호)                        |
| 구문 분석  | (S (NP 나/Noun) 는/Josa (NP 그/Noun 사 과/Noun) 를/Josa (VP 먹었다/Verb)./ Punctuation) | (S (NP 너/Noun) 는/Josa (NP 그/Noun) 를/ Josa (NP 사랑/Noun) (VP 하니/Verb) ?/ Punctuation) |
| 의미 분석  | 술부: 먹다 행위자: 나 대상: 그 과자                                                         | 술부: 사랑하다 행위자: 너 대상: 그                                                               |
| 담화 분석  | 단순 서술                                                                          | 의문형                                                                                 |

## Korean Part-of-Speech (POS) Tagging

The process of assigning word classes (or POS tags) to each word in a sentence is called POS tagging. In Korean, this process involves understanding the complex morphological and syntactic structures of the language.

**한국어의 5언 9품사**

| 언   | 품사          |
|-----|-------------|
| 체언  | 명사, 대명사, 수사 |
| 수식언 | 관형사, 부사     |
| 관계언 | 조사          |
| 독립언 | 감탄사         |
| 용언  | 동사, 형용사     |

Korean is classified into five types of words (언), which are further divided into nine POS categories:

- 체언: Nouns (명사), Pronouns (대명사), and Numbers (수사)
- 수식언: Determinatives (관형사) and Adverbs (부사)
- 관계언: Particles (조사)
- 독립언: Interjections (감탄사)
- 용언: Verbs (동사) and Adjectives (형용사)

In particular, '동사' (Verbs) and '형용사' (Adjectives) that fall under '용언' are combined with stems and endings to form a word. The word classification is based on three criteria: function, meaning, and form.

## Morphological Analysis in Korean

In Korean, a sentence can be analyzed at different levels such as morphological, syntactic, semantic, and discourse levels. Morphological analysis is the process of breaking down words into their smallest meaningful units (morphemes) and assigning them appropriate POS tags.

For example, consider the sentence: "나는 그 과자를 먹었다." (I ate that cookie.). A morphological analysis would break down the sentence as follows:

나(대명사) + 는(조사) + 그(대명사) + 과자(명사) + 먹(동사) + -었(선어말어미) + -다(어말어미) + .(문장부호)

## Linguistic (Grammatical) Classification

### Isolating, Inflectional, and Agglutinative Languages

- Agglutinative(교착어): Languages that indicate the function of each word by attaching affixes to roots.
- Inflectional(굴절어): Languages that use changes in the word itself to indicate its grammatical function.
- Isolating(고립어): Languages that establish grammatical relationships based on word order, without changing the form of words.

### Agglutinative Languages

- Ural-Altaic agglutinative languages determine the final meaning of a word by attaching affixes to it.
- For instance, in Korean, the root '나 (I)' can be combined with affixes like '은/는/이/가' to form a subject and '을/를' to form an object.
- The verb tense is also determined by attaching affixes to the root.
- For example, '가다 (go)' can change to '갔다 (went)', '갔었다 (had gone)' by changing affixes.

### Isolating Languages

- Languages such as Chinese and Tibetan are isolating languages, which determine the meaning of words based on word order.
- For example, in Chinese, '我 (I)' and '去 (go)' can form '我去 (I go)' in a certain order, but if the order is changed to '去我', it means 'make me go'.
- The form of the word '我' and '去' does not change, but the meaning changes depending on the order.
- Chinese and Tibetan languages are called isolating because the form of words does not change independently, but the meaning of words changes depending on the order and context.

### Inflectional Languages

- Indo-European inflectional languages determine the meaning of a word by changing the word's form.
- A representative inflectional language is Latin.
- For instance, the English word 'good' comes from the Latin word 'bonus', where the affix '-us' denotes masculine singular nominative case.
- If you want to express a different attribute, you replace the affix with another, for example, replacing '-us' with '-um' to form 'bonum', which is masculine singular accusative (or neuter singular accusative/nominative).
- Inflectional languages change the form of words by attaching different affixes for each element of the word such as case, gender, tense, number, part of speech.
- Indo-European languages are inflectional languages where the meaning of the word changes as the form of the word inflects.
- Inflectional languages are not greatly influenced by word order because each word has all the grammatical elements.

## Morphological Analysis (Part of Speech Tagging)

### What is Morphological Analysis?

- It is the process of dividing sentences into morpheme units, distinguishing parts of speech, tagging them, and restoring the phenomenon of morpheme dropout due to various uses of verbs.
- The morpheme division method varies depending on the analyzer, so you need to choose an analyzer that matches the data.
- Morphological analysis plays the most important and basic role in all language natural language processing processes.
- Application of Morphological Analysis:
  - Linguistic aspect: Can be used to explain the generation process of a specific language phenomenon.
  - Computational aspect: Can be used for purposes such as information retrieval or syntax analysis in automatic natural language processing systems.

### Conjugation (활용)

- **Stem (어간):** This is the invariant part of a verb or adjective in principle when it is conjugated. It precedes the ending in a conjugated form. However, sometimes, even the stem can change (For example, 긋다 (to draw) can become 긋고 (and draw), 그어서 (after drawing), 그어라 (draw!)).

- **Ending (어미):** This is the part attached to the stem of a verb or adjective during conjugation. The ending changes depending on the grammatical function it is performing, such as tense, mood, honorific form, etc.

Conjugation rules in Korean can be divided into regular and irregular forms.

- **Regular Conjugation (규칙 활용):** In regular conjugation, the stem remains the same when the ending is attached. For example, 잡다 (to catch) can be broken down into 잡 (stem) + 다 (ending). As the stem retains its form before and after the ending is attached, simple rule-based approaches can extract the stem by removing the ending.

- **Irregular Conjugation (불규칙 활용):** In irregular conjugation, the stem or the ending changes when the stem takes an ending. Examples of this irregular change include:
    - 듣- (to listen), 돕- (to help), 곱- (to be beautiful), 잇- (to continue), 오르- (to rise), 노랗- (to be yellow) becomes 듣/들-, 돕/도우-, 곱/고우-, 잇/이-, 오르/올-, 노랗/노라-.
    - 오르 + 아/어 becomes 올라, 하 + 아/어 becomes 하여, 이르 + 아/어 becomes 이르러.
  As the stem changes when the ending is attached, simple removal of the ending is not enough to extract the stem, and more complex rules are needed.

Considering these points, it is evident that Korean tokenization, especially when it involves conjugation, is a task of substantial complexity. It requires robust morphological analysis or statistical methods to efficiently and correctly tokenize the language.

### Difficulty of Korean Tokenization

- Agglutinative Language: Korean is an agglutinative language, where words are formed by combining morphemes, which are the smallest meaningful units of language. Each morpheme in an agglutinative language like Korean has a clear meaning and grammatical function, and they can be freely added or removed to change the meaning of the word. This is different from languages like English where the meaning of a word is generally fixed and doesn't change much with the addition or removal of morphemes. This morphological complexity of Korean poses a significant challenge in tokenization.

- Word Boundaries: Another challenge in Korean tokenization is the lack of clear word boundaries. Unlike English where words are usually separated by spaces, Korean uses spaces to separate phrases or sentences rather than individual words. This makes it harder to define what constitutes a "word" in Korean, and consequently makes tokenization more difficult.

- Particles: Korean also uses a variety of particles to indicate the grammatical role of a word in a sentence. These particles (also known as postpositions) can be attached to the end of a noun to indicate the noun's role, such as subject, object, or location. The same noun can take on different meanings depending on the particle attached to it. This use of particles adds an extra layer of complexity to Korean tokenization.

- Homonyms: Korean also has a high degree of homonymy, meaning that there are many words that sound the same but have different meanings. This can make it hard to tokenize Korean text correctly, as the tokenizer has to be able to determine the correct meaning of a word based on its context.

- Compound Nouns: Korean frequently uses compound nouns, where two or more nouns are combined to form a new word. The meaning of a compound noun can often be different from the meanings of its individual components, which can add to the complexity of tokenization.

Because of these challenges, Korean tokenization often requires more complex techniques than simple space-based tokenization. This might include morphological analysis, which breaks down words into their individual morphemes and assigns them appropriate part-of-speech tags, and statistical methods, which use machine learning algorithms to predict the most likely tokenization of a sentence based on training data.
  
