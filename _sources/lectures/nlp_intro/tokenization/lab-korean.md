eKoNLPy is built on the [fugashi](https://github.com/polm/fugashi) and [mecab-ko-dic](https://github.com/LuminosoInsight/mecab-ko-dic) libraries. For more information on using the `Mecab` tagger, please refer to the [fugashi documentation](https://github.com/polm/fugashi). As eKoNLPy no longer relies on the [KoNLPy](https://konlpy.org) library, Java is not required for its use. This makes eKoNLPy compatible with Windows, Linux, and Mac OS, without the need for Java installation. You can also use eKoNLPy on Google Colab.

If you wish to tokenize general Korean text with eKoNLPy, you do not need to install the `KoNLPy` library. Instead, utilize `ekonlpy.mecab.MeCab` as a replacement for `ekonlpy.tag.Mecab`.

However, if you plan to use the [Korean Sentiment Analyzer (KSA)](#korean-sentiment-analyzer-ksa), which employs the `Kkma` morpheme analyzer, you will need to install the [KoNLPy](https://konlpy.org) library.

## Installation

To install eKoNLPy, run the following command:

```bash
pip install ekonlpy
```

## Usage

### Part of Speech Tagging

To use the part of speech tagging feature, input `Mecab.pos(phrase)` just like KoNLPy. First, the input is processed using KoNLPy's Mecab morpheme analyzer. Then, if a combination of consecutive tokens matches a term in the user dictionary, the phrase is separated into compound nouns.

```python
from ekonlpy.tag import Mecab

mecab = Mecab()
mecab.pos('금통위는 따라서 물가안정과 병행, 경기상황에 유의하는 금리정책을 펼쳐나가기로 했다고 밝혔다.')
```

> [('금', 'MAJ'), ('통', 'MAG'), ('위', 'NNG'), ('는', 'JX'), ('따라서', 'MAJ'), ('물가', 'NNG'), ('안정', 'NNG'), ('과', 'JC'), ('병행', 'NNG'), (',', 'SC'), ('경기', 'NNG'), ('상황', 'NNG'), ('에', 'JKB'), ('유의', 'NNG'), ('하', 'XSV'), ('는', 'ETM'), ('금리', 'NNG'), ('정책', 'NNG'), ('을', 'JKO'), ('펼쳐', 'VV+EC'), ('나가', 'VX'), ('기', 'ETN'), ('로', 'JKB'), ('했', 'VV+EP'), ('다고', 'EC'), ('밝혔', 'VV+EP'), ('다', 'EF'), ('.', 'SF')]

### cf. MeCab POS Tagging (fugashi)

```python
from ekonlpy.mecab import MeCab # Be careful! `C` is capital.

mecab = MeCab()
mecab.pos('금통위는 따라서 물가안정과 병행, 경기상황에 유의하는 금리정책을 펼쳐나가기로 했다고 밝혔다.')
```

> [('금', 'MAJ'), ('통', 'MAG'), ('위', 'NNG'), ('는', 'JX'), ('따라서', 'MAJ'), ('물가', 'NNG'), ('안정', 'NNG'), ('과', 'JC'), ('병행', 'NNG'), (',', 'SC'), ('경기', 'NNG'), ('상황', 'NNG'), ('에', 'JKB'), ('유의', 'NNG'), ('하', 'XSV'), ('는', 'ETM'), ('금리', 'NNG'), ('정책', 'NNG'), ('을', 'JKO'), ('펼쳐', 'VV+EC'), ('나가', 'VX'), ('기', 'ETN'), ('로', 'JKB'), ('했', 'VV+EP'), ('다고', 'EC'), ('밝혔', 'VV+EP'), ('다', 'EF'), ('.', 'SF')]

### Lemmatization and Synonyms

To enhance the accuracy of sentiment analysis, eKoNLPy offers lemmatization and synonym handling features.

### Adding Words to Dictionary

You can add words to the dictionary in the `ekonlpy.tag` module's Mecab class, either as a string or a list of strings, using the `add_dictionary` method.

```python
from ekonlpy.tag import Mecab

mecab = Mecab()
mecab.add_dictionary('금통위', 'NNG')
```

# Python 한국어 형태소 분석기

### 꼬꼬마 형태소 분석기: Kkma

- 서울대학교 IDS (Intelligent Data Systems) 연구실에서 자연어 처리를 위한 모듈구축과제로 개발한 형태소 분석기
- Java 언어를 기반으로. 하며, Python-Java 연동을 통해 Python에서 사용 가능함
- 동적 프로그래밍 (Dynamic Programming) 방식으로 가능한 모든 형태소 후보를 모두 찾아 가장 적합한 형태소를 판단함 → 매우느림

### 코모란 형태소 분석기: Komoran

- Shineware에서 개발된 한국어 형태소 분석기로서 Java Library 형태(jar)로 제공됨
- 타 형태소 분석기와 달리 여러 어절을 하나의 품사로 분석 가능함으로써 공백이 포함된 고유명사(영화 제목, 음식점 명 등)를 정확하게 분석

### Mecab 형태소 분석기: Mecab

- 일본어용 형태소 분석기를 한국어를 사용할 수 있도록 수정
- 사용자 사전 등록기능을 제공하여 댜양한 도메인에서 생성되는 단어들을 인식할 수 있도록 도와줌

### 한나눔 형태소 분석기: Hannanum

- KAIST Semantic Web Research Center (SWRC)에서 개발한 형태소 분석기
- 자동 띄어쓰기 모듈을 제공해 형태소 분석 결과를 활용하여 한글 문장에 대한 자동 띄어쓰기 수행 가능
- 사전 기반의 맞춤법 교정 모듈로 형태소 분석 결과를 활용하여 한글 단어에 대한 맞춤법 교정 수행 가능

### Khaiii (Kakao Hangul Analyzer III)

- 카카오에서 DHA2 (Daumkakao Hangul Analyzer 2)를 계승하여 개발하고 2018년 공개된 두 번째 버전의 형태 소분석기
- 속도를 매우 중요시하여 신경망 알고리즘들 중에서 Convolutional Neural Network (CNN)을 사용하여 개발됨
- 사용자 사전 등록기능을 제공하여 댜양한 도메인에서 생성되는 단어들을 인식할 수 있도록 도와줌

### 오픈 소스 한국어 분석기: Open Korean Text (Okt)

- 과거 트위터 형태소 분석기 (Twitter)
- SNS에서 발생하는 언어에서 자주 발생하는 인물명, 신조어 등을 잘 인식하는 편이며, 속도가 빠르지만 형태소 분석 품질은 상대적으로 낮음

```
text = """
한편 IMF가 추정한 우리나라의 GDP갭률은 금년에도 소폭의 마이너스(-)를 지속하고 있는데, 잠재성장률 추정의 불확실성을
감안하더라도 최근의 고용상황, 제조업가동률, 물가상승률 등에 비추어 볼 때 동 추정치가 어느 정도 타당성이 있어 보인다고
언급하면서 관련부서의 견해를 물었음.
"""
```

```python
from konlpy.tag import Kkma
kkma = Kkma()
kkma.pos(text)
```

```
[('한편', 'NNG'), ('IMF', 'OL'), ('가', 'JKS'), ('추정', 'NNG'), ('하', 'XSV'), ('ㄴ', 'ETD'),
('우리나라', 'NNG'), ('의', 'JKG'), ('GDP', 'OL'), ('갭', 'NNG'), ('률', 'XSN'), ('은', 'JX'),
('금년', 'NNG'), ('에', 'JKM'), ('도', 'JX'), ('소폭', 'NNG'), ('의', 'JKG'), ('마이너스', 'NNG'),
('(', 'SS'), ('-', 'SW'), (')', 'SS'), ('를', 'JKO'), ('지속', 'NNG'), ('하', 'XSV'), ('고', 'ECE'),
('있', 'VXV'), ('는데', 'ECD'), (',', 'SP'), ('잠재', 'NNG'), ('성장률', 'NNG'), ('추정', 'NNG'),
('의', 'JKG'), ('불확실', 'NNG'), ('성', 'XSN'), ('을', 'JKO'), ('감안', 'NNG'), ('하', 'XSV'),
('더라도', 'ECD'), ('최근', 'NNG'), ('의', 'JKG'), ('고용', 'NNG'), ('상황', 'NNG'), (',', 'SP'),
('제조업', 'NNG'), ('가동률', 'NNG'), (',', 'SP'), ('물가', 'NNG'), ('상승률', 'NNG'), ('등', 'NNB'),
('에', 'JKM'), ('비추', 'VV'), ('어', 'ECD'), ('보', 'VV'), ('ㄹ', 'ETD'), ('때', 'NNG'), ('동', 'NNG'),
('추', 'NNG'), ('정치', 'NNG'), ('가', 'JKS'), ('어느', 'MDT'), ('정도', 'NNG'), ('타당성', 'NNG'),
('이', 'JKS'), ('있', 'VV'), ('어', 'ECD'), ('보이', 'VV'), ('ㄴ다고', 'ECE'), ('언급', 'NNG'), ('하', 'XSV'),
('면서', 'ECE'), ('관련', 'NNG'), ('부서', 'NNG'), ('의', 'JKG'), ('견해', 'NNG'), ('를', 'JKO'),
('묻', 'VV'), ('었', 'EPT'), ('음', 'ETN'), ('.', 'SF')]
```

# Sentence Segmentation: KSS

Kss: A Toolkit for Korean sentence segmentation
GitHub release Issues

This repository contains the source code of Kss, a representative Korean sentence segmentation toolkit. I also conduct ongoing research about Korean sentence segmentation algorithms and report the results to this repository. If you have some good ideas about Korean sentence segmentation, please feel free to talk through the issue.

pip install kss

1) split_sentences: split text into sentences
from kss import split_sentences

split_sentences(
    text: Union[str, List[str], Tuple[str]],
    backend: str = "auto",
    num_workers: Union[int, str] = "auto" ,
    strip: bool = True,
    ignores: List[str] = None,
)


```python
text = "일본기상청과 태평양지진해일경보센터는 3월 11일 오후 2시 49분경에 일본 동해안을 비롯하여 대만, 알래스카, 하와이, 괌,
캘리포니아, 칠레 등 태평양 연안 50여 국가에 지진해일 주의보와 경보를 발령하였다. 다행히도 우리나라는 지진발생위치로부터
1,000km 이상 떨어진데다 일본 열도가 가로막아 지진해일이 도달하지 않았다. 지진해일은 일본 소마항에 7.3m, 카마이시항에 4.1m,
미야코항에 4m 등 일본 동해안 전역에서 관측되었다. 지진해일이 원해로 전파되면서 대만(19시 40분)에서 소규모 지진해일과 하와이
섬에서 1.4m(23시 9분)의 지진해일이 관측되었다. 다음날인 3월 12일 새벽 1시 57분경에는 진앙지로부터 약 7,500km 떨어진
캘리포니아 크레센트시티에서 2.2m의 지진해일이 관측되었다."
```
